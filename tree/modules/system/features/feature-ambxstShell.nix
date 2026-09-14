{inputs, ...}:
with inputs.ambxst-shell; {
  flake.modules.nixos.feature-ambxstShell = {system, ...}: {
    imports = [
      nixosModules.default
    ];

    environment.systemPackages = [
      packages.${system}.default
    ];
  };
}
