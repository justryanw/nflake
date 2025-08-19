{
  config,
  lib,
  ...
}: let
  cfg = config.modules.homepage;
in {
  options.modules.homepage = {
    enable = lib.mkEnableOption "Enable hoempage";
  };

  config = lib.mkIf cfg.enable {
    services = {
      homepage-dashboard = {
        enable = true;
        allowedHosts = "localhost,${config.networking.hostName}.local,127.0.0.1";
        widgets = [
          {
            resources = {
              cpu = true;
              memory = true;
              refresh = 500;
              cputemp = true;
              tempmin = 30;
              tempmax = 90;
            };
          }
          {
            resources = {
              label = "Root";
              disk = "/";
            };
          }
        ];
        services = [
          {
            Media = [
              {
                Jellyfin = lib.mkIf config.modules.jellyfin.enable {
                  icon = "jellyfin.png";
                  href = "http://${config.networking.hostName}.local:8096";
                };
              }
              {
                Arm = lib.mkIf config.modules.arm.enable {
                  href = "http://${config.networking.hostName}.local:8080";
                };
              }
            ];
          }
          {
            Monitoring = [
              {
                Glances = lib.mkIf config.modules.glances.enable {
                  href = "http://${config.networking.hostName}.local:61208";
                };
              }
            ];
          }
        ];
      };
      caddy = {
        enable = true;
        virtualHosts = {
          ":80".extraConfig = ''
            reverse_proxy :8082
          '';
        };
      };
    };
    networking.firewall.allowedTCPPorts = [80];
  };
}
