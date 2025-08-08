{...}: {
  imports = [./hardware-configuration.nix];

  modules = {
    users = {
      kevin.enable = true;
      ryan.enable = true;
    };
    systemd-boot.enable = true;
    gnome.enable = true;
    yggdrasil.enable = true;
    ssh.enable = true;
    arm.enable = true;
    jellyfin.enable = true;
  };

  networking.hostName = "jack";

  fileSystems = {
    "/data" = {
      device = "/dev/disk/by-uuid/ed1835a7-e55c-4cf3-bb4c-60d9e03be010";
      fsType = "btrfs";
    };
  };

  system.stateVersion = "25.05";
}
