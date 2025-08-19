{...}: {
  imports = [./hardware-configuration.nix];

  modules = {
    users = {
      kevin.enable = true;
      ryan.enable = true;
    };
    systemd-boot.enable = true;
    gnome.enable = true;
    ssh.enable = true;
    arm.enable = true;
    jellyfin.enable = true;
    zerotier.enable = true;
    iperf.enable = true;
    homepage.enable = true;
  };

  networking.hostName = "jack";
  system.stateVersion = "25.05";

  fileSystems = {
    "/data" = {
      device = "/dev/disk/by-uuid/ed1835a7-e55c-4cf3-bb4c-60d9e03be010";
      fsType = "btrfs";
    };
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 32 * 1024;
    }
  ];
}
