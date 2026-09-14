{
  flake.modules.nixos.misc-disableGreeter = {
    services = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = false;
      xserver = {
        videoDrivers = ["modesetting"];
        displayManager.lightdm.enable = false;
        enable = true;
      };
    };

    xdg.portal = {
      enable = true;
    };
  };
}
