{inputs, ...}: {
  flake.modules.nixos = {
    packageSet-fromFlake = {system, ...}: {
      environment.systemPackages = with inputs; [
        # quickshell.packages.${system}.default
      ];
    };

    packageSet-languageServers = {pkgs, ...}: {
      qt.enable = true; # for quickshell lsp
      environment.systemPackages = with pkgs; [
        bash-language-server # LSP for Bash scripts
        # glsl_analyzer # LSP for GLSL shaders
        # glslls # alternative GLSL language server
        haskell-language-server # LSP for Haskell
        nixd # LSP for Nix expressions
        taplo # TOML LSP and formatter
        vscode-langservers-extracted # HTML/CSS/JSON/ESLint LSPs
        svelte-language-server
        superhtml # HTML LSPs
        lua-language-server # lua lsp
        luajitPackages.jsregexp # idfk but lua
        stylua # lua formatter
      ];
    };

    packageSet-formatters = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        alejandra # opinionated Nix code formatter
        jsonfmt # JSON formatter
        kdlfmt # KDL document formatter
        # nodePackages.prettier # multi-language code formatter
        sqruff # sql formatter
        nufmt # Nushell script formatter
      ];
    };

    packageSet-linters = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        shellcheck # shell script static analysis
        statix # Nix code linter
      ];
    };

    packageSet-compilers = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        irust # rust repl
        gcc # GNU C/C++ compiler
        gnumake # for make!
        cargo # rust
        python3 # Python 3.10 interpreter
        steel # embeddable Scheme interpreter
        (ghc.withPackages (hsPkgs:
          with hsPkgs; [
            QuickCheck # property-based testing library
            ihaskell # Haskell Jupyter kernel
            shh # shell scripting in Haskell
            shh-extras # extra utilities for shh
            turtle # shell scripting DSL
          ]))
      ];
    };

    packageSet-databases = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        duckdb # fast in-process analytical database
        sqlite # lightweight embedded SQL database
      ];
    };

    packageSet-containers = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        devenv # fast reproducible dev environments
        dive # explore Docker image layers
        podman # daemonless container engine
        podman-compose #
        podman-desktop #
      ];
    };

    packageSet-nixTools = {
      pkgs,
      system,
      ...
    }: {
      programs = {
        nix-ld.enable = true;
        nh = {
          enable = true;
          package = inputs.nh.packages.${system}.default;
          clean.extraArgs = "--keep-since 7d --keep 7";
          flake = "/etc/nixos";
          clean.enable = true;
        };
      };

      environment.systemPackages = with pkgs; [
        comma # run programs without installing
        home-manager # manage user dotfiles with Nix
        nix-index # index nixpkgs files for searching
        nix-init # generate Nix packages from URLs
        nix-melt # ranger-like flake.lock viewer
      ];
    };

    packageSet-editors = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        helix # vim,kakoune-inspired rust-written tui text editor
      ];
    };

    packageSet-shellEnhancements = {pkgs, ...}: {
      programs.tmux.enable = true;
      environment.systemPackages = with pkgs; [
        bat # cat with syntax highlighting
        btop # resource monitor with TUI
        eza # modern ls replacement
        fd # fast find alternative
        fzf # fuzzy finder for terminal
        glow # render markdown in terminal
        ripgrep # fast recursive grep replacement
        zoxide # smarter cd with frecency
        tmuxinator # tmux session manager
        jujutsu # git-compatible version control system
        carapace # multi-shell completion library
        carapace-bridge # bridge to external completions
      ];
    };

    packageSet-fileUtils = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        ouch # painless compression/decompression tool
        stow # symlink farm manager
        trash-cli # trash files from command line
        tree # display directory trees
        unzip # extract ZIP archives
        tig # git helper
        zip # zip
        superfile # like yazi
      ];
    };

    packageSet-processUtils = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        witr # ps but better, traces processes
        daemonize # run programs as daemons
        direnv # per-directory environment variables
        hyperfine # command-line benchmarking tool
        inotify-info # show inotify watch statistics
        inotify-tools # CLI for inotify filesystem events
        screen # terminal multiplexer
        wev # wayland event viewer
      ];
    };

    packageSet-hardwareInfo = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        acpi # display ACPI battery/power info
        inxi # full system information tool
        intel-gpu-tools # Intel GPU debugging utilities
        lm_sensors # read hardware sensor data
        lshw # detailed hardware listing
        pciutils # PCI device utilities (lspci)
        usbutils # USB device utilities (lsusb)
      ];
    };

    packageSet-hardwareControl = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        brightnessctl # control screen brightness
        ddcutil # control monitors via DDC/CI
        esptool # flash ESP8266/ESP32 microcontrollers
        evtest # input device event testing
        keyd # key remapping daemon
        xrandr # configure display outputs
      ];
    };

    packageSet-systemMonitoring = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        lsof # list open files and sockets
        sysstat # system performance tools (sar)
      ];
    };

    packageSet-networkUtils = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        cloudflared # Cloudflare Tunnel client
        dnsutils # DNS utilities (dig, nslookup)
        iw # wireless device configuration
        wget # download files from web
        inetutils # common network programs, e.g. telnet
        macchanger # changes mac address
      ];
    };

    packageSet-security = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        openssl # TLS/SSL cryptography toolkit
      ];
    };

    packageSet-guiApps = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        kitty # GPU-accelerated terminal emulator
        waybar # who doesnt know this
      ];
    };

    packageSet-waylandUtils = {pkgs, ...}: {
      programs.xwayland.enable = true;
      environment.systemPackages = with pkgs; [
        slurp # select screen region interactively
        awww # animated wallpaper daemon
        wf-recorder # screen recorder for Wayland
      ];
    };

    packageSet-clipboard = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        wl-clipboard-rs # Wayland clipboard utilities
        xclip # X11 clipboard CLI tool
      ];
    };

    packageSet-audio = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        mpc # MPD command-line client
        mpd # music player daemon
        playerctl # control MPRIS media players
        pulseaudio # PulseAudio sound server tools
      ];
    };

    packageSet-mediaTools = {pkgs, ...}: {
      programs.obs-studio.enable = true;
      environment.systemPackages = with pkgs; [
        asciinema # record terminal sessions
        exiftool # read/write file metadata
        mediainfo # display media file information
        mpv # versatile media player
        cine # media player
      ];
    };

    packageSet-docs = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        man-pages # Linux man pages
        man-pages-posix # POSIX man pages
        pandoc # universal document converter
        tldr # simplified community man pages
      ];
    };

    packageSet-systemInfo = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        fastfetch # fast system info display
        pkg-config # info for packages
      ];
    };

    packageSet-qtLibs = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        qt5.qtgraphicaleffects # Qt5 visual effects module
        ncurses # terminal UI library
        qt6.qt5compat # Qt5 compatibility for Qt6
        qt6.qtdeclarative # Qt6 QML engine
      ];
    };
  };
}
