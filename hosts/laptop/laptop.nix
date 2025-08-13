{...}: {
  imports = [./hardware-configuration.nix];

  modules = {
    users.ryan.enable = true;
    ssh.enable = true;
    gnome.enable = true;
    zerotier.enable = true;
  };

  networking.hostName = "laptop";
  system.stateVersion = "22.11";

  boot.loader.grub.device = "nodev";

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];
}
