{
  flake.modules.nixos.feature-crabHole = {
    services.crab-hole = {
      enable = false;

      settings = {
        blocklist = {
          include_subdomains = true;
          lists = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts"
            "https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt"
            "https://adaway.org/hosts.txt"
            "https://v.firebog.net/hosts/Easyprivacy.txt"
          ];
        };
        downstream = [
          {protocol = "udp"; listen = "127.0.0.1"; port = 53;}
          {protocol = "udp"; listen = "::1"; port = 53;}
        ];
        upstream = {
          name_servers = [
            {
              socket_addr = "1.1.1.1:853";
              protocol = "tls";
              tls_dns_name = "1dot1dot1dot1.cloudflare-dns.com";
              trust_nx_responses = false;
            }
            {
              socket_addr = "[2606:4700:4700::1111]:853";
              protocol = "tls";
              tls_dns_name = "1dot1dot1dot1.cloudflare-dns.com";
              trust_nx_responses = false;
            }
          ];
        };
      };
    };
  };
}
