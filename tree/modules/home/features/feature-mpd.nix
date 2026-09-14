{
  flake.modules.homeManager.feature-mpd = {
    home.sessionVariables.MPD_HOST = "localhost";
    services.mpd = {
      enable = true;
      musicDirectory = "/home/alice/saves/music";
      network.listenAddress = "any";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire Sound Server"
        }
        audio_output {
          type   "fifo"
          name   "my_fifo"
          path   "/tmp/mpd.fifo"
          format "44100:16:2"
        }
      '';
    };
  };
}
