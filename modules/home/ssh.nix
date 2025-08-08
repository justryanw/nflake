{
  config,
  lib,
  ...
}: let
  cfg = config.modules.ssh;
in {
  options.modules.ssh = {
    enable = lib.mkEnableOption "Enable ssh";
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        github = {
          user = "git";
          hostname = "github.com";
        };

        nixbuild.hostname = "eu.nixbuild.net";
      };
    };
  };
}
