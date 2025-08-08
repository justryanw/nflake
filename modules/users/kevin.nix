{
  config,
  lib,
  ...
}: let
  cfg = config.modules.users.kevin;
in {
  options.modules.users.kevin = {
    enable = lib.mkEnableOption "Enable kevin";
  };

  config = lib.mkIf cfg.enable {
    users.users.kevin = {
      isNormalUser = true;
      description = "Kevin";
      extraGroups = ["networkmanager" "wheel"];
      initialHashedPassword = "$y$j9T$/UmFk3nW2QPdgBbsMx8IU/$397HJU2T65uWe12MP4u38IEJNcmE9sX7teI2fU1USRA";

      openssh.authorizedKeys.keys = import ./ryan/keys.nix;
    };
  };
}
