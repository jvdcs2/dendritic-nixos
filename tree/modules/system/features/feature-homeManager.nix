{inputs, ...}: {
  flake.modules.nixos.feature-homeManager = {system, ...}: {
    imports = [
      inputs.home-manager.nixosModules.default
    ];
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "backup";
      extraSpecialArgs = {inherit inputs system;};
    };
  };
}
