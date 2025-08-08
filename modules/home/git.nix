{
  config,
  lib,
  ...
}: let
  cfg = config.modules.git;
in {
  options.modules.git = {
    enable = lib.mkEnableOption "Enable git config";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Ryan Walker";
      userEmail = "ryanjwalker2001@gmail.com";
    };
  };
}
