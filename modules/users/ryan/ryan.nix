{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.users.ryan;
in {
  options.modules.users.ryan = {
    enable = lib.mkEnableOption "Enable ryan";
  };

  config = lib.mkIf cfg.enable {
    users.users.ryan = {
      isNormalUser = true;
      description = "Ryan";
      extraGroups = ["networkmanager" "wheel"];
      initialHashedPassword = "$y$j9T$/0D7TzdJ47wVaY77j8gnJ.$RKHvm/DQTTD8xCdx1ZRhhj9fMuiP5kocHXRmwBBPPR1";
      shell = pkgs.zsh;

      openssh.authorizedKeys.keys = import ./keys.nix;
    };

    home-manager.users.ryan = import ./home.nix;
  };
}
