boot.initrd.kernalModules = [ "amdgpu" ];
services.xserver.videoDrivers = [ "amdgpu" ];

environment.systemPackages = [
    pkgs.firefox,
    pkgs.qtile,
    pkgs.flameshot,
    pkgs.steam,
    pkgs.wayland,
    pkgs.neovim,
    pkgs.tmux,
    pkgs.zsh,
    pkgs.kitty,
    pkgs.bat,
    pkgs.fzf,
    pkgs.git,
    pkgs.google-cloud-sdk,
    pkgs.mullvad-vpn,
    pkgs.python312
];
