# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "main"; # Define your hostname.
# reless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Perth";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "au";
    xkb.variant = "";
    enable = true;
    displayManager.gdm.enable = true;
  };

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

  location = {
    provider = "manual";
    longitude = 115.8617;
    latitude = 31.9514;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.denial = {
    isNormalUser = true;
    description = "Denial";
    extraGroups = [ "networkmanager" "wheel" "audio"];
    packages = with pkgs; [];
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Desktop stuff
    swww # wallpaper control
    dunst # notification app
    kitty # terminal emulator
    rofi-wayland # app launcher
    xdg-desktop-portal-gtk # portal
    xdg-desktop-portal-hyprland # portal
    wl-clipboard # clipboard functionality
    wlr-randr # monitor manager
    swaylock-effects # lock functionality
    pavucontrol # control audio
    hyprpicker # colour picker
    (waybar.overrideAttrs (oldAttrs: {
                           mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
                           })) # desktop bar
    inotify-tools # used for waybar reloading script
    # CLI Utils
    fzf # fuzzy finder
    ripgrep # faster grep
    dnsutils # dig
    zsh-powerlevel10k # cli status line
    zplug # zsh plugin manager
    git
    bat # better cat
    cifs-utils # samba mounting
    # Apps
    brave # browser
    obs-studio # recorder/streaming
    obsidian # note taking
    discord # friend chat Electrum
    # development
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    font-awesome # nice fonts
    powerline-fonts # more nice fonts with icons
    gcc # required for treesitter
    go # golang
    pyenv # python environment/version manager
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Meslo" ]; })
  ];

  fileSystems."/mnt/share" = {
    device = "//home.denial.id.au/denial";
    fsType = "cifs";
    options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";
    in ["${automount_opts},credentials=/etc/nixos/smb_secrets,uid=1000,gid=100"];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamescope.enable = true;

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    shellAliases = {
      la = "ls -al";
      ll = "ls -l";
      v = "nvim";
    };
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      power-theme
      gruvbox
      continuum
      better-mouse-mode
    ];
  };
  programs.fzf.keybindings = true;
  programs.fzf.fuzzyCompletion = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
