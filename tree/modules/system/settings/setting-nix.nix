{inputs, ...}: {
  flake.modules.nixos.setting-nix = {
    imports = [
      inputs.determinate.nixosModules.default
    ];

    nixpkgs.config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      permittedInsecurePackages = ["electron-39.8.10"];
    };

    zramSwap.enable = true;

    nix = {
      extraOptions = ''
        experimental-features = nix-command pipe-operators
        fallback = true
      '';
      settings = {
        max-jobs = 1;
        cores = 0; # 0 = use as many allowed
        auto-optimise-store = true;
        substituters = [
          "https://nix-community.cachix.org"
          "https://vicinae.cachix.org"
          "https://noctalia.cachix.org"
          "https://cache.nixos.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
        connect-timeout = 5;
        stalled-download-timeout = 5;
        http-connections = 128;
      };
    };
  };
}
