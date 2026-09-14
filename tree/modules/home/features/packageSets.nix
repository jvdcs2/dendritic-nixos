{
  flake.modules.homeManager = {
    packageSet-viewers = {pkgs, ...}: {
      home.packages = with pkgs; [
        sioyek # keyboard-driven PDF viewer
        qimgv # lightweight image viewer
        swayimg # Wayland native image viewer
      ];
    };

    packageSet-latex = {pkgs, ...}: {
      home.packages = with pkgs; [
        texliveFull # complete LaTeX distribution
        ghostscript # PostScript/PDF interpreter
      ];
    };

    packageSet-typst = {pkgs, ...}: {
      home.packages = with pkgs; [
        tree-sitter-grammars.tree-sitter-typst # typst syntax tree parser
        tree-sitter # parser generator tool
        typst # modern typesetting system
        tinymist # typst language server
        typstyle # typst formatter
      ];
    };

    packageSet-lsps = {pkgs, ...}: {
      home.packages = with pkgs; [
        marksman # markdown lsp
        markdown-oxide
      ];
    };

    packageSet-mediaTools = {pkgs, ...}: {
      home.packages = with pkgs; [
        ffmpeg # audio/video converter swiss army knife
        spotdl # download Spotify tracks
        yt-dlp # download YouTube videos
      ];
    };

    packageSet-audioVisualizers = {pkgs, ...}: {
      home.packages = with pkgs; [
        iniparser # INI file parser (cava dep)
        fftw # fast fourier transform library
        cava # console audio visualizer
      ];
    };

    packageSet-shell = {pkgs, ...}: {
      home.packages = with pkgs; [
        starship # cross-shell prompt
        nushell # structured data shell
        fish # shell for nushell completions
      ];
    };

    packageSet-terminalTools = {pkgs, ...}: {
      home.packages = with pkgs; [
        asciiquarium-transparent # aquarium in terminal
        unoconv # document format converter
        lynx # text-based web browser
        djvulibre # djvu converter
        calibre # various library converter stuff
        djvu2pdf # the name
        poppler-utils # includes a pdf to image converter
      ];
    };

    packageSet-creative = {pkgs, ...}: {
      home.packages = with pkgs; [
        # kdePackages.kdenlive # video editor
        obs-studio # streaming/recording
        easyeffects # PipeWire audio effects
        pinta # simple image editor
        # aseprite # pixelart editor
        # vmpk # virtual keyboard
        # zrythm # DAW
        # lmms # DAW
        reaper # DAW
        # ardour # DAW
      ];
    };

    packageSet-games = {pkgs, ...}: {
      home.packages = with pkgs; [
        # osu-lazer
        prismlauncher # minecraft
      ];
    };

    packageSet-productivity = {pkgs, ...}: {
      home.packages = with pkgs; [
        syncthing # file synchronization
        onlyoffice-desktopeditors
        rclone
        rclone-browser
        rclone-ui
        qutebrowser # lightweight python-QT browser
        slack # discord but for the employed
        obsidian # markdown knowledge base
        todoist-electron # synchronized todo
        # gocryptfs # encrypted filesystem
        # newsflash # rss reader
        google-chrome
        fragments # torrents
        transmission_4-gtk # torrents
        firefox
        caprine # messenger
        lastfm # music tracker
        zotero # citation thingy
      ];
    };
  };
}
