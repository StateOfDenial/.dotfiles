{ inputs, ... }:
{
  flake.modules.nixos.secrets = { config, lib, pkgs, ... }: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    sops.age.keyFile = "/var/lib/sops-nix/key.txt";
    sops.age.generateKey = true;
    sops.defaultSopsFile = ./../../secrets.yaml;
  };
}
