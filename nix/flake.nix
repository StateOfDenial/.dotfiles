{
  description = "My NixOS setup.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = { nixpkgs, home-manager, aagl, ghostty, ... } @ inputs: let
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
            programs.honkers-railway-launcher.enable = true;
            programs.honkers-launcher.enable = true;
            environment.systemPackages = [
                ghostty.packages.x86_64-linux.default
            ];
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
