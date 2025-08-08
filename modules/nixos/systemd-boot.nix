{
  lib,
  config,
  ...
}: {
  options = {
    modules.systemd-boot.enable = lib.mkEnableOption "Enable systemd-boot";
  };

  config = lib.mkIf config.modules.systemd-boot.enable {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
