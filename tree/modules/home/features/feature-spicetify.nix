{inputs, ...}: {
  flake.modules.homeManager.feature-spicetify = {system, ...}: {
    imports = [
      inputs.spicetify-nix.homeManagerModules.default
    ];
    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
    in {
      enable = true;
      wayland = true; # force native Wayland (ozone) flags
      enabledExtensions = with spicePkgs.extensions; [
        adblock
      ];
    };
  };
}
