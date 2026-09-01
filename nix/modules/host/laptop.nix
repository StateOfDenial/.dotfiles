{ self, inputs, ... }:
{
  flake.modules.nixos.laptop = { config, lib, pkgs, ... }:
    let
      mkCifs = device: {
        fsType = "cifs";
        options = let
          automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";
        in [ "${automount_opts},credentials=/run/secrets/smb-secrets,uid=1000,gid=100" ];
        inherit device;
      };
    in {
      imports = [
        inputs.self.modules.nixos.base
        inputs.self.modules.nixos.network
        inputs.self.modules.nixos.locale
        inputs.self.modules.nixos.desktop
        inputs.self.modules.nixos.gaming
        inputs.self.modules.nixos.security
        inputs.self.modules.nixos.storage
        inputs.self.modules.nixos.virtualisation
        inputs.self.modules.nixos.dev
        inputs.self.modules.nixos.secrets
        ../../hosts/laptop/hardware-configuration.nix
      ];

      networking.hostName = "laptop";
      networking.firewall.enable = false;

      system.stateVersion = "23.11";

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      hardware.keyboard.zsa.enable = true;

      fileSystems."/mnt/share" = mkCifs "//home.denial.id.au/denial";

      fileSystems."/mnt/everyone" = mkCifs "//home.denial.id.au/Shared Folder";

      sops.secrets."smb-secrets" = {
        owner = "root";
        group = "root";
        mode = "0600";
      };

      environment.systemPackages = with pkgs; [
        cifs-utils
      ];
    };

  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ inputs.self.modules.nixos.main ];
  };
}
