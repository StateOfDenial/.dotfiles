{ ... }:
{
  flake.modules.nixos.base = { pkgs, lib, ... }: {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    zramSwap.enable = true;

    users.defaultUserShell = pkgs.zsh;

    # These options only generate /etc/zshrc, /etc/tmux.conf and /etc/fzf...
    # which are shadowed by the stow'd configs (~/.zshrc, ~/.tmux.conf).
    # Kept as a NixOS-managed fallback if the stow'd files are ever removed.
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

    environment.systemPackages = with pkgs; [
      fzf
      zsh-powerlevel10k
      zplug

      # CLI Utils
      ripgrep
      dnsutils
      git
      bat
      unzip
      charm-freeze
      stow

      neovim
      gcc
      lua51Packages.luarocks
    ];
  };
}
