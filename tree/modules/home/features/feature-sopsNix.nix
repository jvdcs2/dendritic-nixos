{inputs, ...}: {
  flake.modules.homeManager.feature-sopsNix = {
    # system,
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      sops
      age
      ssh-to-age
    ];
    imports = [
      inputs.sops-nix.homeManagerModules.default
    ];

    sops = {
      defaultSopsFile = /etc/nixos/secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
    };
  };
}
