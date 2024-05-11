{
  description = "My NixOS setup.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, aagl, ... } @ inputs: let
    customLib = import ./lib/default.nix {inherit inputs;};
    system = "x86_64-linux";
  in
  {

    nixosConfigurations = {
      main = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/main/configuration.nix
          {
            imports = [ aagl.nixosModules.default ];
            nix.settings = aagl.nixConfig;
            programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
            programs.anime-games-launcher.enable = true;
            programs.anime-borb-launcher.enable = true;
            programs.honkers-railway-launcher.enable = true;
            programs.honkers-launcher.enable = true;
          }
        ];
      };
    };

    homeConfigurations = {
      "denial@main" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};

	modules = [
	  ./hosts/main/home.nix
	];
      };
    };

  };
}
