{
  flake.modules.nixos.misc-generalServices = {pkgs, ...}: {
    # ============================================
    # KEYRING / SECRETS
    # ============================================
    services.gnome.evolution-data-server.enable = true;
    services.gnome.gnome-online-accounts.enable = true;
    services.gnome.gnome-keyring.enable = true;
    environment.systemPackages = with pkgs; [
      gnome-control-center
    ];

    # ============================================
    # USER ACCOUNTS (for settings panels)
    # ============================================
    services.accounts-daemon.enable = true;

    # ============================================
    # FIRMWARE UPDATES (BIOS, peripherals via LVFS)
    # ============================================
    # Wiki: https://wiki.nixos.org/wiki/Fwupd
    services.fwupd.enable = true;
    services.fwupd.extraRemotes = ["lvfs-testing"]; # for Intel BIOS updates

    # ============================================
    # USB/DISK AUTOMOUNTING
    # ============================================
    services.udisks2.enable = true;

    # ============================================
    # TRASH, MTP (phone file transfer), NETWORK SHARES
    # ============================================
    services.gvfs.enable = true;

    # ============================================
    # THUMBNAILS IN FILE MANAGERS
    # ============================================
    services.tumbler.enable = true;

    # ============================================
    # BATTERY/POWER INFO (for system tray, etc.)
    # ============================================
    services.upower.enable = true;

    programs.nm-applet.enable = true;
    services = {
      power-profiles-daemon.enable = false;
      ratbagd.enable = true;
      openssh.enable = true;
      fstrim.interval = "daily";
      fstrim.enable = true;
      dbus.enable = true;
    };

    programs.dconf.enable = true;
  };
}
