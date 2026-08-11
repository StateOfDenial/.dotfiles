{ ... }:
{
  flake.modules.nixos.storage = { config, lib, pkgs, ... }: {
    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    environment.systemPackages = with pkgs; [
      usbutils
      udiskie
      udisks
    ];
  };
}
