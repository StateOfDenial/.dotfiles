{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [];

  nixpkgs = {
    config = {
      allowUnfree = true;
      experimental-features = "nix-command flakes";
    };
  };

  myHomeManager.zsh.enable = lib.mkDefault true;
  myHomeManager.lf.enable = lib.mkDefault true;
  myHomeManager.yazi.enable = lib.mkDefault true;
  myHomeManager.nix-extra.enable = lib.mkDefault true;
  myHomeManager.bottom.enable = lib.mkDefault true;
  myHomeManager.nix-direnv.enable = lib.mkDefault true;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    file
    git
    p7zip
    unzip
    zip
    stow
    killall
    neovim

    fzf
    htop
    lf
    eza
    fd
    bat
    du-dust
    ripgrep
    neofetch
    lazygit

    ffmpeg
    wget

    yt-dlp
    tree-sitter

    nh
  ];

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/nixconf";
  };
}
