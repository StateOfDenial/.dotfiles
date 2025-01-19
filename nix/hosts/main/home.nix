{ config, pkgs, ... }:
{
  home.username = "denial";
  home.homeDirectory = "/home/denial";

  home.packages = with pkgs; [
    fzf
    htop
    neovim
    zplug
    tenv
    pyenv
    zsh-powerlevel10k
    bat
    neofetch
    vimPlugins.codeium-vim
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      v = "nvim";
      la = "ls -al";
      cat = "bat";
    };

    history = {
      expireDuplicatesFirst = true;
      save = 10000;
      size = 10000;
    };
    initExtra = ''
    PATH=$PATH:~/.local/scripts

    if [ -n "command -v fzf" ]; then
      source "${pkgs.fzf}/share/fzf/key-bindings.zsh"
      source "${pkgs.fzf}/share/fzf/completion.zsh"
    fi
    '';
    initExtraFirst = ''
    if [[ -r "$\{XDG_CACHE_HOME:-$HOME/.cache\}/p10k-instant-prompt-$\{(%):-%n\}.zsh" ]]; then
      source "$\{XDG_CACHE_HOME:-$HOME/.cache\}/p10k-instant-prompt-$\{(%):-%n\}.zsh"
    fi
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

/*  stylix = {
      image = /home/denial/Downloads/greenforest.jpg;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
      fonts = {
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DevaVu Serif";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DevaVu Sans";
        };
        monospace = {
          package = (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; });
          name = "Meslo";
        };
      };

      targets = {
        bemenu.enable = false;
      };
  };*/

  programs.git = {
    enable = true;
    userName = "StateOfDenial";
    userEmail = "daniel.brown715@gmail.com";
  };

  # home = {
  #   file = {
  #     ".zshrc".source = ../../../zsh/.zshrc;
  #     ".p10k.zsh".source = ../../../zsh/.p10k.zsh;
  #     ".tmux.conf".source = ../../../tmux/.tmux.conf;
  #     ".config/kitty/kitty.conf".source = ../../../kitty/.config/kitty/kitty.conf;
  #     ".config/hypr/hyprland.conf".source = ../../../hypr/.config/hypr/hyprland.conf;
  #     ".config/hypr/hyprlock.conf".source = ../../../hypr/.config/hypr/hyprlock.conf;
  #     ".config/ghostty/config".source = ../../../ghostty/.config/ghostty/config;
  #     ".config/nvim" = {
  #       source = ../../../nvim/.config/nvim;
  #       recursive = true;
  #     };
  #     ".config/waybar" = {
  #       source = ../../../waybar/.config/waybar;
  #       recursive = true;
  #     };
  #     ".local/scripts" = {
  #       source = ../../../bin/.local/scripts;
  #       recursive = true;
  #     };
  #   };
  # };


  home.stateVersion = "23.11";

  # programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
