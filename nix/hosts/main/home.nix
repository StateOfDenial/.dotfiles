{ config, pkgs, ... }:
{
  home.username = "denial";
  home.homeDirectory = "/home/denial";

  home.packages = with pkgs; [
    htop
    neovim
    cowsay
    zplug
    zsh-powerlevel10k
  ];

  programs.git = {
    enable = true;
    userName = "StateOfDenial";
    userEmail = "daniel.brown715@gmail.com";
  };

  home = {
    file = {
      ".zshrc".source = ../../../zsh/.zshrc;
      #".p10k.zsh".source = ../../../zsh/.p10k.zsh;
      ".tmux.conf".source = ../../../tmux/.tmux.conf;
      ".config/kitty/kitty.conf".source = ../../../kitty/.config/kitty/kitty.conf;
    };
  };


  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
