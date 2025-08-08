{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.helix;
in {
  options.modules.helix = {
    enable = lib.mkEnableOption "Enable helix";
  };

  config = lib.mkIf cfg.enable {
    programs.helix = {
      enable = true;
      package = pkgs.evil-helix;
      settings = {
        theme = "onedark";
        editor = {
          line-number = "relative";
          auto-format = true;
        };
      };

      languages = {
        language-server = {
          nil.command = "${pkgs.nil}/bin/nil";
          nixd.command = "${pkgs.nixd}/bin/nixd";
        };

        language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = "${pkgs.alejandra}/bin/alejandra";
            language-servers = [
              "nixd"
              "nil"
            ];
          }
        ];
      };
    };
  };
}
