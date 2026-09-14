{inputs, ...}: {
  flake.modules.nixos.feature-claudeCode = {
    system,
    pkgs,
    ...
  }: {
    nixpkgs.overlays = [inputs.claude-code.overlays.default];
    environment.systemPackages = [pkgs.claude-code];
  };
}
