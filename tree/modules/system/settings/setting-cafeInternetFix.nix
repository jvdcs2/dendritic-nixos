{
  flake.modules.nixos.setting-cafeInternetFix = {pkgs, ...}: {
    networking = {
      networkmanager = {
        enable = true;
        dns = "none"; # Don't let NM touch resolv.conf
        wifi.powersave = false;
      };

      # Use reliable DNS
      nameservers = ["1.1.1.1" "8.8.8.8"];

      # Lock down resolv.conf
      resolvconf.enable = false;
    };

    # Write resolv.conf directly
    environment.etc."resolv.conf".text = ''
      nameserver 1.1.1.1
      nameserver 8.8.8.8
      options edns0 trust-ad
    '';

    # Disable IPv6 (common cafe wifi breaker)
    boot.kernel.sysctl = {
      "net.ipv4.tcp_mtu_probing" = 2;
      "net.ipv6.conf.all.disable_ipv6" = 1;
      "net.ipv6.conf.default.disable_ipv6" = 1;
    };

    # Lower default MTU for wifi interface
    # Replace wlp* with your actual interface if needed
    # systemd.services.wifi-mtu-fix = {
    #   description = "Set lower MTU for shitty networks";
    #   after = ["NetworkManager.service"];
    #   wantedBy = ["multi-user.target"];
    #   script = ''
    #     sleep 5
    #     for iface in /sys/class/net/wlp*; do
    #       name=$(basename "$iface")
    #       ${pkgs.iproute2}/bin/ip link set "$name" mtu 1200
    #     done
    #   '';
    #   serviceConfig = {
    #     Type = "oneshot";
    #     RemainAfterExit = true;
    #   };
    # };

    # NetworkManager dispatcher script for per-connection MTU
    environment.etc."NetworkManager/dispatcher.d/99-mtu".source = pkgs.writeShellScript "99-mtu" ''
      [ "$2" = "up" ] && ${pkgs.iproute2}/bin/ip link set "$1" mtu 1200
    '';
  };
}
