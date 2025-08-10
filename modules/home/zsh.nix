{
  config,
  lib,
  ...
}: let
  cfg = config.modules.zsh;
in {
  options.modules.zsh = {
    enable = lib.mkEnableOption "Enable zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      history.size = 1000;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        la = "ls -A";
        sys = "sudo systemctl";
        usr = "systemctl --user";
        disks = "df -h -x tmpfs -x efivarfs -x devtmpfs";
        bios = "systemctl reboot --firmware-setup";
        self = "yggdrasilctl getself";
        peers = "yggdrasilctl getpeers";
        follow = "journalctl -fu";
      };
      initContent = ''
        bindkey '^E' autosuggest-accept
      '';
    };
  };
}
