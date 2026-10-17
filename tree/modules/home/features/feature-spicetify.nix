{inputs, ...}: {
  flake.modules.homeManager.feature-spicetify = {
    system,
    pkgs,
    ...
  }: {
    imports = [
      inputs.spicetify-nix.homeManagerModules.default
    ];
    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${system};

      # Where "home" sends you. null = last playlist you opened (falls back to Liked Songs).
      # Or pin one, e.g. "/playlist/37i9dQZF1DXcBWIGoYBM5M" or "/collection/tracks"
      landingPage = null;

      spicyLyricsHotkey = {
        name = "spicyLyricsHotkey.js";
        src = pkgs.writeTextDir "spicyLyricsHotkey.js" ''
          (function init() {
            if(!window.Spicetify?.Keyboard) return setTimeout(init, 300);
            const open = () => {
              if (document.querySelector("#SpicyLyricsPage.Fullscreen")) return;
              document.getElementById("SpicyLyrics_FullscreenButton")?.click();
            };
            Spicetify.Keyboard.registerShortcut("f", open);
            Spicetify.Keyboard.registerShortcut({ key: "f", shift: true }, open);
          })();
        '';
      };

      uiTweaks = {
        name = "uiTweaks.js";
        src = pkgs.writeTextDir "uiTweaks.js" ''
          (function () {
            // --- Spicy Lyrics: force "Disable Popup Lyrics Window" ON before it reads its settings
            try {
              const key = "SL:settings";
              const s = JSON.parse(localStorage.getItem(key) || "{}");
              if (s.popupLyricsAllowed !== false) {
                s.popupLyricsAllowed = false;
                localStorage.setItem(key, JSON.stringify(s));
              }
            } catch (e) {}
            // fallback: if the button still gets registered, hide it (its own inline !important beats CSS)
            new MutationObserver(() => {
              const b = document.getElementById("SpicyLyrics_PopupLyricsButton");
              if (b) b.style.setProperty("display", "none", "important");
            }).observe(document.documentElement, { childList: true, subtree: true });

            const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
            const waitFor = async (sel, ms) => {
              for (let t = 0; t < ms; t += 100) {
                const el = document.querySelector(sel);
                if (el) return el;
                await sleep(100);
              }
              return null;
            };

            // --- Force compact track list on playlists
            let compacting = false;
            async function forceCompact() {
              if (compacting) return;
              compacting = true;
              try {
                const list = await waitFor(".main-trackList-trackList, [data-testid=\"playlist-tracklist\"]", 5000);
                if (!list || document.querySelector(".main-trackList-trackListCompactMode")) return;
                const toggle = document.querySelector("button[aria-controls^=\"sortboxlist\"]");
                if (!toggle) return;
                toggle.click();
                const menu = await waitFor("#context-menu, [role=\"menu\"]", 1000);
                if (!menu) return;
                const item = [...menu.querySelectorAll("button, [role^=\"menuitem\"]")]
                  .find((b) => b.textContent.trim() === "Compact");
                if (item) item.click();
                await sleep(50);
                if (menu.isConnected) toggle.click();
              } finally {
                compacting = false;
              }
            }

            // --- No home: redirect "/" to a playlist
            const LANDING = ${builtins.toJSON landingPage};
            const LAST = "uiTweaks:lastPlaylist";
            const isPlaylist = (p) => /^\/(playlist\/|collection\/tracks)/.test(p);

            (function init() {
              const H = window.Spicetify?.Platform?.History;
              if (!H) return setTimeout(init, 100);
              const onRoute = (loc) => {
                const p = loc?.pathname || "";
                if (p === "/" || p === "/home") {
                  H.replace(LANDING || localStorage.getItem(LAST) || "/collection/tracks");
                  return;
                }
                if (isPlaylist(p)) {
                  localStorage.setItem(LAST, p);
                  forceCompact();
                }
              };
              H.listen((l) => onRoute(l?.location || l));
              onRoute(H.location);
            })();
          })();
        '';
      };

      hidePlaylistDownload = ''
        .x-downloadButton-DownloadButton,
        .x-downloadButton-button,
        [data-testid="download-button"],
        button[aria-label="Download"] { display: none !important; }
      '';

      hideHomeButton = ''
        [data-testid="home-button"],
        a[href="/"][aria-label="Home"],
        button[aria-label="Home"] { display: none !important; }
      '';

      hideConnectButton = ''
        .main-devicePicker-controlButton,
        [data-restore-focus-key="device_picker"],
        button[aria-label="Connect to a device"] { display: none !important; }
      '';
    in {
      enable = true;
      wayland = true; # force native Wayland (ozone) flags
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        spicyLyrics
        hidePodcasts
        spicyLyricsHotkey
        uiTweaks
      ];
      enabledSnippets = with spicePkgs.snippets; [
        hideFriendActivityButton # top bar: Friend Activity
        hideWhatsNewButton # top bar: What's New bell
        hideDownloadButton # playlist/album download button (old class, no !important)
        removeBrowse # top bar: Browse button next to search
        hideMiniPlayerButton # player bar: mini player
        hideLyricsButton # player bar: native lyrics button (Spicy Lyrics replaces it)
        removeConnectBar # green "Listening on…" bar
        hideAudiobooksButton # library filter chip
        hidePodcastButton # library filter chip
        hideScrollThroughPreviews # "preview" button on album/playlist pages
        disableRecommendations # Home: still useful for the split second Home flashes on startup

        # also hide these if you don't use them:
        # hideNowPlayingViewButton  # player bar: right-sidebar Now Playing panel toggle
        # declutterNowPlayingBar    # Now Playing panel: strips artist bio, credits, tour cards
        hideProfileUsername # top bar: your display name

        hidePlaylistDownload # playlist download button, forced
        hideHomeButton # top bar: Home button
        hideConnectButton # player bar: Connect to a device
      ];
    };
  };
}
