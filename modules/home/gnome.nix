{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.gnome;
in {
  options.modules.gnome = {
    enable = lib.mkEnableOption "Enable Gnome configuration";
  };

  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/peripherals/mouse" = {
        speed = 0.5;
        accel-profile = "flat";
        natural-scroll = false;
      };
      "org/gnome/desktop/wm/keybindings" = {
        toggle-fullscreen = ["<Super>f"];
        minimize = ["<Super>s"];
        maximize = ["<Super>w"];
        begin-move = ["<Super>e"];
        begin-resize = ["<Super>r"];
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = ["<Super>a"];
        toggle-tiled-right = ["<Super>d"];
      };
      "org/gnome/desktop/calendar".show-weekdate = true;
      "org/gtk/settings/file-chooser".clock-format = "12h";
      "org/gnome/desktop/background" = {
        picture-uri = ''file://${pkgs.nixos-artwork.wallpapers.nineish.gnomeFilePath}'';
        picture-uri-dark = ''file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}'';
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
      };
      "org/gnome/desktop/input-sources" = {
        xkb-options = ["caps:escape"];
        sources = [
          (lib.hm.gvariant.mkTuple [
            "xkb"
            "gb"
          ])
        ];
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
        natural-scroll = false;
      };
    };
  };
}
