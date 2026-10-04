{...}: {
  flake.modules.nixos.feature-termfilechooser = {
    pkgs,
    lib,
    ...
  }: let
    p = "org.freedesktop.impl.portal";
    f = lib.mkForce;
  in {
    # The picker, and niri's routing with file picking sent to yazi
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-termfilechooser
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
      config.niri = {
        default = f ["gnome" "gtk"];
        "${p}.Access" = f ["gtk"];
        "${p}.Notification" = f ["gtk"];
        "${p}.Secret" = f ["gnome-keyring"];
        "${p}.FileChooser" = f ["termfilechooser"];
      };
    };

    # Qt apps: Stylix's own setting for which dialogs Qt uses
    home-manager.sharedModules = [
      {stylix.targets.qt.standardDialogs = "xdgdesktopportal";}
    ];
  };
}
