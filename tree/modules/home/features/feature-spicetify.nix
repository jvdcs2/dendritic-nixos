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
    in {
      enable = true;
      wayland = true; # force native Wayland (ozone) flags
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        spicyLyrics
        hidePodcasts
        spicyLyricsHotkey
      ];
      enabledSnippets = with spicePkgs.snippets; [
        hideFriendActivityButton # top bar: Friend Activity
        hideWhatsNewButton # top bar: What's New bell
        hideDownloadButton # top bar: "Install App"
        removeBrowse # top bar: Browse button next to search
        hideMiniPlayerButton # player bar: mini player
        hideLyricsButton # player bar: native lyrics button (Spicy Lyrics replaces it)
        removeConnectBar # green "Listening on…" bar
        hideAudiobooksButton # library filter chip
        hidePodcastButton # library filter chip
        hideScrollThroughPreviews # "preview" button on album/playlist pages
        disableRecommendations # Home: keeps only your shortcuts + recently played

        # also hide these if you don't use them:
        # hideNowPlayingViewButton  # player bar: right-sidebar Now Playing panel toggle
        # declutterNowPlayingBar    # Now Playing panel: strips artist bio, credits, tour cards
        # hideProfileUsername       # top bar: your display name
      ];
    };
  };
}
