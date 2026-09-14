{inputs, ...}: {
  flake.modules.nixos.feature-asusctl = {pkgs, ...}: {
    # services.asusd = {
    #   enable = true;
    #   enableUserService = true;
    # };

    # Ensure asusctl is installed for command-line usage
    environment.systemPackages = with pkgs; [
      asusctl
    ];
  };
}
