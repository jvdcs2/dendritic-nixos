{
  flake.modules.nixos.feature-docker = {pkgs, ...}: {
    environment.systemPackages = pkgs.lib.mkDefault [pkgs.docker-language-server];
    virtualisation.docker.enable = true;
  };
}
