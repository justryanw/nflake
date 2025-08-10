{
  lib,
  config,
  ...
}: let
  cfg = config.modules.zerotier;
in {
  options = {
    modules.zerotier.enable = lib.mkEnableOption "Enable zerotier";
  };

  config = lib.mkIf cfg.enable {
    services.zerotierone = {
      enable = true;
      joinNetworks = ["d3ecf5726d350938"];
    };
  };
}
