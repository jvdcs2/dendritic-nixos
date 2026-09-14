{
  flake.modules.nixos.feature-gaming = {
    hardware.steam-hardware.enable = true;
    programs = {
      gamescope.enable = true;
      gamescope.capSysNice = true;
      steam.enable = true;
      steam.remotePlay.openFirewall = true;
      steam.gamescopeSession.enable = true;
      steam.dedicatedServer.openFirewall = true;
      steam.localNetworkGameTransfers.openFirewall = true;
    };
  };
}
