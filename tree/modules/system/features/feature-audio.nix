{
  flake.modules.nixos.feature-audio = {pkgs, ...}: {
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      alsa.enable = true;
      extraConfig.pipewire = {
        "myClock" = {
          "context.properties" = {
            "default.clock.rate" = 192000;
            "resample.quality" = 10;
          };
        };
      };
    };

    environment.systemPackages = [
      pkgs.alsa-utils
    ];

    # https://discourse.nixos.org/t/problems-adjusting-pipewire-sample-rate-nixos/43346/10
    systemd.services.mpd.serviceConfig.SupplementaryGroups = ["pipewire"];
  };
}
