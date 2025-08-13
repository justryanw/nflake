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
    ../../home/ssh.nix
    ../../home/zsh.nix
  ];

  modules = {
    firefox.enable = true;
    git.enable = true;
    zed.enable = true;
    helix.enable = true;
    gnome.enable = true;
    ssh.enable = true;
    zsh.enable = true;
  };

  home = {
    stateVersion = osConfig.system.stateVersion;

    packages = with pkgs; [
      tldr
      discord
    ];
  };

  programs = {
    starship.enable = true;
    zellij.enable = true;
    btop.enable = true;
    carapace.enable = true;
  };
}
