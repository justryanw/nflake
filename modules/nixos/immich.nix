{
  config,
  lib,
  ...
}: let
  cfg = config.modules.immich;
in {
  options.modules.immich = {
    enable = lib.mkEnableOption "Enable Immich";
  };

  config = lib.mkIf cfg.enable {
    services = {
      immich = {
        enable = true;
        mediaLocation = "/data/immich";
        openFirewall = true;
        host = "0.0.0.0";
      };
    };
  };
}
