{ ... }:
{
  flake.modules.nixos.network = { config, lib, pkgs, ... }: {
    networking.networkmanager.enable = true;
    environment.etc.hosts.mode = "0644";

    services.mullvad-vpn.enable = true;

    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };

    services.zerotierone = {
      enable = true;
      joinNetworks = [ "166359304e70388d" ];
    };
  };
}
