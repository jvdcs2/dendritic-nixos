{
  flake.modules.nixos.feature-rclone = {pkgs, ...}: {
    environment.systemPackages = [pkgs.rclone];
    environment.etc."rclone-mnt.conf".text = ''
      [myremote]
      type = sftp
      host = frybo
      user = alice
      key_file = /root/.ssh/id_rsa
    '';
    fileSystems."/mnt" = {
      device = "myremote:/my_data";
      fsType = "rclone";
      options = [
        "_netdev"
        "nodev"
        "nofail"
        "allow_other"
        "args2env"
        "config=/etc/rclone-mnt.conf"
      ];
    };
  };
}
