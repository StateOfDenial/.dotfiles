# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Perth";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

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

  programs.steam.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "au";
    xkbVariant = "";
    enable = true;
    displayManager = {
      #lightdm.enable = true;
      #lightdm.greeters.gtk.enable = true;
      gdm.enable = true;
    };
    desktopManager = {
      #gnome.enable = true;
      xfce.enable = true;
    };
    windowManager = {
      #qtile.enable = true;
      #qtile.backend = "wayland";
      #qtile.package = pkgs.qtile;
    };
  };

      nixpkgs.overlays = [
  (self: super: {
    qtile-unwrapped = super.qtile-unwrapped.overrideAttrs(_: rec {
      postInstall = let
        qtileSession = ''
[Desktop Entry]
Name=Qtile Wayland
Comment=Qtile on Wayland
Exec=qtile start -b wayland
Type=Application
'';
      in
        ''
mkdir -p $out/share/wayland-sessions
echo "${qtileSession}" > $out/share/wayland-sessions/qtile.desktop
'';
      passthru.providedSessions = [ "qtile" ];
    });
  })
];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.denial = {
    isNormalUser = true;
    description = "Daniel Brown";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    kitty
    tmux
    firefox-wayland
    discord
    zsh
    zplug
    go
    gccgo13
    rustup
    unzip
    fzf
    flameshot
    google-cloud-sdk
    bat
    nodejs_20
    obsidian
    neofetch
    steam
    steam-run
    # qtile stuff
    qtile
    brightnessctl
    alsa-utils
    wofi
    swaybg
    wlr-randr
    
    stow
    cifs-utils
  ];

  hardware.opengl.extraPackages = [
    #pkgs.rocm-opencl-icd
    pkgs.amdvlk
  ];

  /*programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "ls --color=always";
      ll = "ls -l";
      la = "ls -la";
      vim = "nvim";
    };
    history = {
      size = 500000;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      path = "~/.history";
      save = 500000;
      share = true;
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "plugins/git"; }
        { name = "plugins/terraform"; }
        { name = "plugins/kubectl"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
  };*/
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  security = {
    sudo.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
  system.stateVersion = "23.05"; # Did you read the comment?

}
