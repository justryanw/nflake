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
    };
  };
}
