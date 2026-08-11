{ self, inputs, ... }:
{
  flake.modules.nixos.main = { config, lib, pkgs, ... }:
    let
      mkCifs = device: {
        fsType = "cifs";
        options = let
          automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";
        in [ "${automount_opts},credentials=/etc/nixos/smb_secrets,uid=1000,gid=100" ];
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
        ../../hosts/main/hardware-configuration.nix
      ];

      networking.hostName = "main";
      networking.firewall.enable = false;

      system.stateVersion = "23.11";

      services.xserver.videoDrivers = [ "amdgpu" ];

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      hardware.amdgpu = {
        initrd.enable = true;
        overdrive = {
          enable = true;
          ppfeaturemask = "0xffffffff";
        };
      };

      hardware.keyboard.zsa.enable = true;

      fileSystems."/mnt/share" = mkCifs "//home.denial.id.au/denial";

      fileSystems."/mnt/everyone" = mkCifs "//home.denial.id.au/Shared Folder";

      environment.systemPackages = with pkgs; [
        cifs-utils
      ];
    };

  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ inputs.self.modules.nixos.main ];
  };
}
