{
  config,
  lib,
  ...
}: let
  cfg = config.modules.arm;

  armCfgFile = source: {
    inherit source;
    mode = "0775";
    user = "arm";
    group = "media";
  };
in {
  options.modules.arm = {
    enable = lib.mkEnableOption "Enable Automatic Ripping Machine";

    configDir = lib.mkOption {
      type = lib.types.str;
      default = "/etc/arm";
      description = "Path to the ARM configuration directory";
    };
  };

  config = lib.mkIf cfg.enable {
    users = {
      users.arm = {
        isSystemUser = true;
        group = "media";
        extraGroups = ["cdrom" "video" "render" "docker"];
        uid = 1001;
      };
    };

    boot.kernelModules = ["sg"];

    networking.firewall.allowedTCPPorts = [8080];

    systemd.tmpfiles.rules = [
      "d /data 775 root root"
      "d /data/arm 775 arm media"
      "d /etc/arm 775 arm media"
      "d /data/Media/Movies 775 kevin media"
      "d /data/Media/Shows 775 kevin media"
      "d /data/Media/Music 775 kevin media"
      "d /data/Media/Music-Videos 775 kevin media"
    ];

    environment.etc = {
      "arm/arm.yaml" = armCfgFile ./arm.yaml;
      "arm/abcde.conf" = armCfgFile ./abcde.conf;
      "arm/apprise.yaml" = armCfgFile ./apprise.yaml;
    };

    virtualisation = {
      docker = {
        enable = true;
        autoPrune.enable = true;
      };

      oci-containers.containers."arm-ripper" = {
        image = "docker.io/automaticrippingmachine/automatic-ripping-machine:latest";
        ports = ["8080:8080"];
        environment = {
          ARM_UID = "1001";
          ARM_GID = "1001";
        };
        volumes = [
          "/data/arm:/home/arm"
          "/etc/arm:/etc/arm/config"
          # "/data/arm/music:/home/arm/music"
          # "/data/arm/logs:/home/arm/logs"
          # "/data/arm/media:/home/arm/media"
        ];
        devices = [
          "/dev/sr0:/dev/sr0"
          # "/dev/sr1:/dev/sr1"
        ];
        privileged = true;
        autoStart = true;
      };
    };

    services.homepage-dashboard.services = [
      {
        Media = [
          {
            Arm = {
              # icon = "jellyfin.png";
              href = "http://${config.networking.hostName}.local:8080";
            };
          }
        ];
      }
    ];
  };
}
