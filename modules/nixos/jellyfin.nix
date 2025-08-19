{
  config,
  lib,
  ...
}: let
  cfg = config.modules.jellyfin;
in {
  options.modules.jellyfin = {
    enable = lib.mkEnableOption "Enable jellyfin";
  };

  config = lib.mkIf cfg.enable {
    services = {
      jellyfin = {
        enable = true;
        group = "media";
        openFirewall = true;
      };
      homepage-dashboard.services = [
        {
          Media = [
            {
              Jellyfin = {
                icon = "jellyfin.png";
                href = "http://${config.networking.hostName}.local:8096";
              };
            }
          ];
        }
      ];
    };
  };
}
