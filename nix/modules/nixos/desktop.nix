{ ... }:
{
  flake.modules.nixos.desktop = { config, lib, pkgs, ... }: {
    services.xserver = {
      xkb.layout = "au";
      xkb.variant = "";
      enable = true;
      wacom.enable = true;
    };
    programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
    services.displayManager.gdm.enable = true;

    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;

    services.blueman.enable = true;

    services.redshift = {
      enable = true;
      brightness = {
        day = "1.0";
        night = "0.8";
      };
      temperature = {
        day = 10000;
        night = 6000;
      };
    };

    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };

    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
    xdg.icons.enable = true;

    fonts.packages = with pkgs; [
      nerd-fonts.meslo-lg
      baekmuk-ttf
      font-awesome
    ];

    security.pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.extraConfig.bluetoothEnhancements = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
        };
      };
    };
    programs.noisetorch.enable = true;

    environment.sessionVariables = {
      XDG_ICON_DIRS = [
        "${pkgs.material-icons}/share/icons"
      ];
    };

    environment.systemPackages = with pkgs; [
      # Desktop stuff
      awww
      dunst
      kitty
      rofi
      wl-clipboard
      wlr-randr
      swaylock-effects
      pavucontrol
      hyprpicker
      quickshell
      libsForQt5.qt5.qtdeclarative
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      }))
      inotify-tools
      thunar
      hyprshot
      hyprcursor
      hyprlock
      hypridle
      hdrop
      bluez
      glib
      (vicinae.overrideAttrs (oldAttrs: {
        useLayerShell = false;
      }))
      ghostty
      easyeffects
      powerline-fonts
      dracula-icon-theme
      everforest-gtk-theme
      material-icons

      # Apps
      brave
      firefox
      google-chrome
      obs-studio
      obsidian
      discord
      vesktop
      anki
      protonmail-desktop
      shotcut
      libreoffice-qt
      hunspell
      hunspellDicts.en_AU
      remarkable-mouse
    ];
  };
}
