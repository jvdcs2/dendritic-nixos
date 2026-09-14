{inputs, ...}:
with inputs.noctalia-shell; {
  flake.modules.nixos.feature-noctaliaShell = {system, ...}: {
    imports = [
      nixosModules.default
    ];

    environment.systemPackages = [
      packages.${system}.default
    ];

    services.noctalia-shell.enable = true;
  };
}
