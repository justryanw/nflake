{config, ...}: {
  imports = [./hardware-configuration.nix];

  modules = {
    users.ryan.enable = true;
    gnome.enable = true;
    ssh.enable = true;
    disko.enable = true;
    zerotier.enable = true;
    systemd-boot.enable = true;
    steam.enable = true;
    iperf.enable = true;
  };

  networking.hostName = "desktop";
  system.stateVersion = "24.11";

  disko.devices.disk.${config.networking.hostName}.device = "/dev/disk/by-id/nvme-WDS500G3X0C-00SJG0_2018GE480508";

  swapDevices = [
    {
      device = "/swapfile";
      size = 32 * 1024;
    }
  ];
}
