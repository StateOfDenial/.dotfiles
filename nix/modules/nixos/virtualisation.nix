{ ... }:
{
  flake.modules.nixos.virtualisation = { config, lib, pkgs, ... }: {
    virtualisation.podman.enable = true;
    virtualisation.waydroid.enable = true;

    environment.systemPackages = with pkgs; [
      podman-compose
    ];
  };
}
