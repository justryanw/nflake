{
  config,
  lib,
  ...
}: let
  cfg = config.modules.iperf;
in {
  options.modules.iperf = {
    enable = lib.mkEnableOption "Enable iperf";
  };

  config = lib.mkIf cfg.enable {
    services.iperf3 = {
      enable = true;
      openFirewall = true;
    };
  };
}
