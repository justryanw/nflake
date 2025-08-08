{
  osConfig,
  pkgs,
  ...
}: {
  imports = [
    ../../home/zed.nix
    ../../home/firefox.nix
  ];

  modules = {
    zed.enable = true;
    firefox.enable = true;
  };

  home = {
    stateVersion = osConfig.system.stateVersion;

    packages = with pkgs; [
      tldr
    ];
  };

  programs = {
    zsh.enable = true;
    starship.enable = true;

    helix = {
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

    zellij.enable = true;
    btop.enable = true;
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
  };
}
