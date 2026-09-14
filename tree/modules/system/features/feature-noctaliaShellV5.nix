{inputs, ...}:
with inputs.noctalia-shell-v5; {
  flake.modules.nixos.feature-noctaliaShellV5 = {...}: {
    imports = [
      nixosModules.default
    ];
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      recommendedServices.enable = true;
    };
  };
}
