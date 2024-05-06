{
  description = "My NixOS setup.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs: let
    customLib = import ./lib/default.nix {inherit inputs;};
    system = "x86_64-linux";
  in
  {

    nixosConfigurations = {
      main = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  ./hosts/main/configuration.nix
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
