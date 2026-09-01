{ ... }:
{
  flake.modules.nixos.security = { config, lib, pkgs, ... }: {
    # Me, this is all me
    users.users.denial = {
      isNormalUser = true;
      description = "Denial";
      extraGroups = [ "networkmanager" "wheel" "audio" "plugdev" ];
    };

    security.sudo.extraRules = [
      {
        users = [ "denial" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];

    security.polkit.extraConfig = ''
      polkit.addRule(function (action, subject) {
        if ((action.id == "org.corectrl.helper.init" ||
            action.id == "org.corectrl.helperkiller.init") &&
            subject.local == true &&
            subject.active == true &&
            subject.isInGroup("users")) {
          return polkit.Result.YES;
        }
      });
    '';

    # For git signing, probably could live in dev
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      settings = {
        default-cache-ttl = 3600;       # keep unlocked 1h after last use
        max-cache-ttl    = 86400;       # never prompt again for 24h
        default-cache-ttl-ssh = 3600;
        max-cache-ttl-ssh    = 86400;
      };
    };
    services.pcscd.enable = true;

    environment.systemPackages = with pkgs; [
      gnupg
      pinentry-gnome3
    ];
  };
}
