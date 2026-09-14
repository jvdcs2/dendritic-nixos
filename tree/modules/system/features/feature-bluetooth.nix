{
  flake.modules.nixos.feature-bluetooth = {pkgs, ...}: {
    services.pipewire.wireplumber.extraConfig."10-bluez-priority" = {
      "monitor.bluez.rules" = [
        {
          matches = [
            {
              "device.name" = "~bluez_card.40_ED_98_1A_BD_4B";
            }
          ];
          actions = {
            update-props = {
              "priority.driver" = 2000;
              "priority.session" = 2000;
            };
          };
        }
      ];
    };

    environment.systemPackages = [pkgs.bluez];
    services.blueman.enable = true;
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true; # battery level reporting
          FastConnectable = true; # faster pairing (uses more power)
          ControllerMode = "bredr"; # uncomment if BT audio dropouts occur
        };
        Policy = {
          AutoEnable = true; # auto-enable adapters when found
        };
      };
    };
  };
}
