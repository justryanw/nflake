{
  osConfig,
  pkgs,
  ...
}: {
  imports = [
    ../../home/zed.nix
    ../../home/firefox.nix
    ../../home/git.nix
    ../../home/helix.nix
    ../../home/gnome.nix
  ];

  modules = {
    firefox.enable = true;
    git.enable = true;
    zed.enable = true;
    helix.enable = true;
    gnome.enable = true;
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
    zellij.enable = true;
    btop.enable = true;
  };
}
