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

    home-manager.sharedModules = [
      {
        # Qt apps: Stylix's own setting for which dialogs Qt uses
        stylix.targets.qt.standardDialogs = "xdgdesktopportal";

        # OnlyOffice: its menu entry, launched with the portal flag
        xdg.desktopEntries.onlyoffice-desktopeditors = {
          name = "ONLYOFFICE";
          genericName = "Document Editor";
          exec = "onlyoffice-desktopeditors --xdg-desktop-portal=default %U";
          icon = "onlyoffice-desktopeditors";
          categories = ["Office"];
          mimeType = [
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            "application/vnd.openxmlformats-officedocument.presentationml.presentation"
            "application/msword"
            "application/vnd.ms-excel"
            "application/vnd.ms-powerpoint"
            "application/vnd.oasis.opendocument.text"
            "application/vnd.oasis.opendocument.spreadsheet"
            "application/vnd.oasis.opendocument.presentation"
            "text/csv"
          ];
        };
      }
    ];
  };
}
