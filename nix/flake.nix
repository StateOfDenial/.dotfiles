{
  description = "My NixOS setup.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    umu.url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";
    # OpenLinkHub = {
    #   url = "path:./packages/OpenLinkHub/default.nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, chaotic, ... } @ inputs: let
    customLib = import ./lib/default.nix {inherit inputs;};
    system = "x86_64-linux";
  in
  {

    nixosConfigurations = {
      main = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self inputs; };
        modules = [
          ./hosts/main/configuration.nix
          chaotic.nixosModules.default
          ./modules/nixos/OpenLinkHub/default.nix
        ];
      };
    };

  };
}
