{inputs, ...}: {
  flake.modules.nixos.feature-sopsNix = {
    # system,
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      sops
      age
      ssh-to-age
    ];
    imports = [
      inputs.sops-nix.nixosModules.default
    ];
  };
}
