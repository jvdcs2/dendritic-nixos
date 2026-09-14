{
  flake.modules.nixos.feature-networking = {
    networking.networkmanager.enable = true;
    networking.enableIPv6 = false;
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        2234  # nicotine
        8384  # syncthing gui
        22000 # syncthing sync protocol
      ];
      allowedUDPPorts = [
        21027 # syncthing local discovery
        22000 # syncthing sync protocol
      ];
    };
  };
}
