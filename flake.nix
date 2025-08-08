{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    createSystem = name:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;

        modules =
          [
            inputs.home-manager.nixosModules.home-manager
            ./configuration.nix
            ./hosts/${name}/${name}.nix
          ]
          ++ (with self.nixosModules; [
            ryan
            kevin

            ssh
            gnome
            systemd-boot
            grub
            yggdrasil
            arm
            jellyfin
          ]);
      };
  in {
    nixosConfigurations = {
      jack = createSystem "jack";
      laptop = createSystem "laptop";
    };

    nixosModules = {
      ryan = import ./modules/users/ryan/ryan.nix;
      kevin = import ./modules/users/kevin.nix;

      ssh = import ./modules/nixos/ssh.nix;
      gnome = import ./modules/nixos/gnome.nix;
      systemd-boot = import ./modules/nixos/systemd-boot.nix;
      grub = import ./modules/nixos/grub.nix;
      yggdrasil = import ./modules/nixos/yggdrasil.nix;
      arm = import ./modules/nixos/arm/arm.nix;
      jellyfin = import ./modules/nixos/jellyfin.nix;
    };

    homeModules = {
      zed = import ./modules/home/zed.nix;
      firefox = import ./modules/home/firefox.nix;
      git = import ./modules/home/git.nix;
      helix = import ./modules/home/helix.nix;
      gnome = import ./modules/home/gnome.nix;
      ssh = import ./modules/home/ssh.nix;
    };

    homeConfigurations = {
      ryan = import ./modules/users/ryan/home.nix;
    };
  };
}
