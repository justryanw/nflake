{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.gnome;
in {
  options.modules.gnome = {
    enable = lib.mkEnableOption "Enable gnome";
  };

  config = lib.mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
        displayManager.gdm = {
          autoSuspend = false;
          enable = true;
        };
        desktopManager.gnome.enable = true;
        excludePackages = with pkgs; [xterm];
      };
    };

    environment = {
      gnome.excludePackages = with pkgs; [
        totem
        epiphany
        yelp
        geary
        seahorse
        gnome-characters
        gnome-contacts
        gnome-font-viewer
        gnome-logs
        gnome-maps
        gnome-music
        gnome-photos
        gnome-weather
        gnome-tour
        gnome-clocks
      ];

      systemPackages = with pkgs; [celluloid];
    };

    documentation.nixos.enable = false;
  };
}
