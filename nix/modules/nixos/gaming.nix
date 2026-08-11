{ inputs, ... }:
{
  flake.modules.nixos.gaming = { config, lib, pkgs, ... }: {
    services.flatpak.enable = true;

    programs.steam = {
      enable = true;
      package = with pkgs; steam.override { extraPkgs = pkgs: [ pkgs.attr ]; };
    };
    programs.steam.gamescopeSession.enable = false;
    programs.gamescope.enable = true;
    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
      protonup-ng # managing proton versions
      winetricks # managing wine prefixes
      protonplus 
      wine # wine
      heroic # another game launcher
      (retroarch.withCores (cores: with cores; [
        mgba
        desmume
      ])) # emulation
      vintagestory # fun minecraft like game
    ];
  };
}
