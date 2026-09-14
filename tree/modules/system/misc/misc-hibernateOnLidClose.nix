{
  flake.modules.nixos.misc-hibernateOnLidClose = {
    services = {
      logind.settings.Login = {
        HandleLidSwitchExternalPower = "hibernate";
        HandleLidSwitchDocked = "hibernate";
        HandleLidSwitch = "hibernate";
      };
    };
  };
}
