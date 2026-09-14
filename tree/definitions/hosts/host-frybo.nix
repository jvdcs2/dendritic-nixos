{
  library,
  modules,
  helpers,
  ...
}: {
  flake.modules = library.defineHostModule {
    name = "frybo";
    isoVersion = "25.05";
    imports = with modules.nixos; [
      device-ASUS_Zenbook_14_UX3405MA
      user-alice

      (helpers.symlink {
        from = "/etc/nixos/tree/definitions/users/alice/dotfiles";
        to = "/home/alice";
        user = "alice";
      })

      # === MISCELLANEOUS ===
      misc-hibernateOnLidClose
      misc-generalServices
      misc-disableGreeter
      misc-portals
      misc-matplotlibCrispDisplay
      # ===

      # === SETTINGS ===
      setting-disableNiriSessionWarning
      setting-performanceTuning
      setting-fryboVariables
      setting-timezoneLocale
      setting-documentation
      setting-bootLoader
      setting-security
      setting-console
      setting-fonts
      setting-nix
      # setting-cafeInternetFix
      # ===

      # === CREATIVE ===
      feature-bitwigStudio
      # ===

      feature-inputRemapper
      feature-bitwarden
      feature-sopsNix
      feature-asusctl

      feature-geolocation
      feature-homeManager
      feature-networking
      feature-printing
      feature-gaming
      feature-audio
      feature-git

      feature-claudeCode
      feature-bluetooth
      feature-syncthing
      feature-crabHole
      feature-flatpak
      feature-keyd
      # feature-aria
      # feature-vsts

      # === MATH ===
      feature-lean
      # ===

      # === CONTAINERIZATION ===
      feature-podman
      feature-docker
      # feature-homarr
      # ===

      # === SHELLS ===
      # feature-noctaliaShell
      feature-noctaliaShellV5
      # feature-ambxstShell
      # ===

      # === DEs ===
      feature-niri
      # feature-labwc
      # feature-sway
      # feature-hyprland
      # feature-cosmicDe
      # ===

      # === STYLIX ===
      feature-stylix

      setting-stylix-fonts-sleek
      # setting-stylix-fonts-pretty

      setting-stylix-colors-trasmus
      # setting-stylix-colors-rosepine
      # setting-stylix-colors-ashen
      # ===

      # === PACKAGES ===
      packageSet-systemInfo
      packageSet-systemMonitoring

      packageSet-fileUtils
      packageSet-shellEnhancements
      packageSet-networkUtils
      packageSet-processUtils
      packageSet-waylandUtils

      packageSet-guiApps
      packageSet-editors
      packageSet-audio

      packageSet-hardwareControl
      packageSet-languageServers
      packageSet-hardwareInfo
      packageSet-formatters
      packageSet-mediaTools
      packageSet-containers
      packageSet-clipboard
      packageSet-fromFlake
      packageSet-compilers
      packageSet-databases
      packageSet-security
      packageSet-linters
      packageSet-nixTools
      packageSet-docs
      # packageSet-qtLibs
      # ===
    ];
  };
}
