{
  config,
  lib,
  ...
}: let
  cfg = config.modules.ssh;
in {
  options.modules.ssh = {
    enable = lib.mkEnableOption "Enable openssh";
  };

  config = lib.mkIf cfg.enable {
    services = {
      openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };
    };
  };
}
