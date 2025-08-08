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
  in {
    nixosConfigurations = {
      jack = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;

        modules =
          [
            inputs.home-manager.nixosModules.home-manager
            ./configuration.nix
            ./hosts/jack/jack.nix
          ]
          ++ (with self.nixosModules; [
            gnome
            yggdrasil
            ssh
            arm
            jellyfin
            kevin
            ryan
          ]);
      };
    };

    nixosModules = {
      yggdrasil = import ./modules/nixos/yggdrasil.nix;
      ssh = import ./modules/nixos/ssh.nix;
      arm = import ./modules/nixos/arm/arm.nix;
      jellyfin = import ./modules/nixos/jellyfin.nix;
      gnome = import ./modules/nixos/gnome.nix;
      kevin = import ./modules/users/kevin.nix;
      ryan = import ./modules/users/ryan/ryan.nix;
    };

    homeModules = {
      zed = import ./modules/home/zed.nix;
      firefox = import ./modules/home/firefox.nix;
    };

    homeConfigurations = {
      ryan = import ./modules/users/ryan/home.nix;
    };
  };
}
