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
      userEmail = "git@ryanjw.net";
      extraConfig = {
        pull.rebase = true;
        rebase.autoStash = true;
        submodule.recurse = true;
        push.recurseSubmodules = "on-demand";
      };
      aliases = {
        a = "!git add -A";
        ac = "!git add -A && git commit";
        acm = "!git add -A && git commit -m";
      };
    };
  };
}
