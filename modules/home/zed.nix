{
  config,
  lib,
  ...
}: let
  cfg = config.modules.zed;
in {
  options.modules.zed = {
    enable = lib.mkEnableOption "Enable zed";
  };

  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      userSettings = {
        theme = {
          mode = "system";
          light = "One Light";
          dark = "One Dark";
        };
        vim_mode = true;
        languages = {
          Nix = {
            formatter = {
              external = {
                command = "alejandra";
              };
            };
          };
        };
      };
    };
  };
}
