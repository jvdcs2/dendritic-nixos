{
  flake.modules.nixos.feature-podman = {pkgs, ...}: {
    environment.systemPackages = pkgs.lib.mkDefault [pkgs.docker-language-server];
    virtualisation.podman = {
      enable = true;
      # dockerCompat = true; # Creates a 'docker' alias for podman
      defaultNetwork.settings.dns_enabled = true; # Allows containers to talk to eachother by name

      # networkSocket = {
      #   server = "ghostunnel";
      #   enable = true;
      #   openFirewall = true;
      # };
    };
  };
}
