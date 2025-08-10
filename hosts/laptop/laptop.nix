{...}: {
  imports = [./hardware-configuration.nix];

  modules = {
    users.ryan.enable = true;
    ssh.enable = true;
    gnome.enable = true;
    zerotier.enable = true;
  };

  system.stateVersion = "22.11";
  networking.hostName = "laptop";

  boot.loader.grub.device = "nodev";

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];
}
