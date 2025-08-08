{
  config,
  lib,
  ...
}: let
  cfg = config.modules.yggdrasil;
in {
  options.modules.yggdrasil = {
    enable = lib.mkEnableOption "Enable yggdrasil";
  };

  config = lib.mkIf cfg.enable {
    services = {
      yggdrasil = {
        enable = true;
        persistentKeys = true;
        group = "wheel";
        openMulticastPort = true;
        settings = {
          MulticastInterfaces = [
            {
              Regex = ".*";
              Beacon = true;
              Listen = true;
              Port = 9001;
              Priority = 0;
            }
          ];
          Peers = [
            "tcp://62.210.85.80:39565"
          ];
        };
      };

      yggdrasil-jumper = {
        enable = true;
      };
    };

    networking = {
      firewall.allowedTCPPorts = [9001];
      nftables = {
        enable = true;
        ruleset = ''
          table inet filter {
            chain input {
              type filter hook input priority 0;

              # Allow specific Yggdrasil IPs first
              define ALLOWED_IPS = {
                200:902:9729:125:a8d3:eca2:d641:4a9b,
                202:8699:42dd:e354:50c5:5a7e:610b:1a18,
                202:bd8a:d171:53b9:deb0:7ac4:3257:80f0,
                206:f181:200:d9af:a582:9074:daba:f2ff,
                201:e7ad:b13b:b71a:9ef2:123e:1e86:ffe0,
                201:f5ff:565:4fef:6597:9c51:654e:f08a,
                202:232d:ecb9:8fdb:4d38:db48:b556:e8d5,
                201:55c7:9286:a3d3:cf7d:bf2a:b270:97a0
              }
              ip6 saddr $ALLOWED_IPS accept

              # Block entire Yggdrasil range
              ip6 saddr 200::/7 drop

              # Standard firewall rules
              ct state established,related accept
              iifname "lo" accept
              ct state invalid drop
            }
          }
        '';
      };
    };
  };
}
