{
  pkgs,
  firefox-addons,
  ...
}: let
  locale = "en_GB.UTF-8";
in {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  users.groups.media = {
    gid = 1001;
    members = ["ryan kevin"];
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  i18n = {
    defaultLocale = locale;

    extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };

  console.keyMap = "uk";

  services = {
    xserver.xkb.layout = "gb";

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  security.rtkit.enable = true;

  programs = {
    firefox.enable = true;
    git.enable = true;
    zsh.enable = true;

    nh = {
      enable = true;
      flake = "/home/ryan/flake";
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    nil
    nixd
    alejandra
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit firefox-addons;
    };
  };

  users.mutableUsers = false;
}
