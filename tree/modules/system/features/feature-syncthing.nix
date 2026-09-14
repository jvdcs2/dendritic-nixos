{
  flake.modules.nixos.feature-syncthing = {pkgs, ...}: {
    services.syncthing = {
      configDir = "/home/alice/.syncthing";
      dataDir = "/home/alice/syncthing";
      openDefaultPorts = true;
      guiAddress = "127.0.0.1:8384";
      user = "alice";
      enable = true;
      package = pkgs.syncthing;
      extraFlags = ["--allow-newer-config"]; # default: [ ]
    };
  };
}
