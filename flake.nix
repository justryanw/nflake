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

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    copyparty = {
      url = "github:9001/copyparty";
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
            ./configuration.nix
            ./hosts/${name}/${name}.nix
          ]
          ++ (with inputs; [
            home-manager.nixosModules.home-manager
            disko.nixosModules.default
            copyparty.nixosModules.default
            ({...}: {nixpkgs.overlays = [copyparty.overlays.default];})
          ])
          ++ (builtins.attrValues self.nixosModules);
      };
  in {
    nixosConfigurations = {
      jack = createSystem "jack";
      laptop = createSystem "laptop";
      desktop = createSystem "desktop";
    };

    nixosModules = {
      ryan = import ./modules/users/ryan/ryan.nix;
      kevin = import ./modules/users/kevin.nix;

      arm = import ./modules/nixos/arm/arm.nix;
      disko = import ./modules/nixos/disko.nix;
      gnome = import ./modules/nixos/gnome.nix;
      grub = import ./modules/nixos/grub.nix;
      jellyfin = import ./modules/nixos/jellyfin.nix;
      ssh = import ./modules/nixos/ssh.nix;
      steam = import ./modules/nixos/steam.nix;
      systemd-boot = import ./modules/nixos/systemd-boot.nix;
      yggdrasil = import ./modules/nixos/yggdrasil.nix;
      zerotier = import ./modules/nixos/zerotier.nix;
    };

    homeModules = {
      firefox = import ./modules/home/firefox.nix;
      git = import ./modules/home/git.nix;
      gnome = import ./modules/home/gnome.nix;
      helix = import ./modules/home/helix.nix;
      ssh = import ./modules/home/ssh.nix;
      zed = import ./modules/home/zed.nix;
      zsh = import ./modules/home/zsh.nix;
    };

    homeConfigurations = {
      ryan = import ./modules/users/ryan/home.nix;
    };
  };
}
