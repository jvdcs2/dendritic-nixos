{
  flake.modules.homeManager.misc-generalServices = {
    services.blueman-applet.enable = true;
    services.network-manager-applet.enable = true;
  };
}
