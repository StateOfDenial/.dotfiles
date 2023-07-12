#!/usr/bin/env bash 

sudo curl -fssLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update
xargs -a ubuntu-packages sudo apt install

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile

brew bundle --file Brewfile.ubuntu

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

if [[ -z $STOW_FOLDERS ]]; then
    STOW_FOLDERS="bin,nvim,tmux,zsh,picom,kitty,"
fi

if [[ -z $DOTFILES ]]; then
    DOTFILES=$HOME/.dotfiles
fi

STOW_FOLDERS=$STOW_FOLDERS DOTFILES=$DOTFILES $DOTFILES/install

#set zsh as default
sudo usermod -s /bin/zsh denial
#qtile install
git clone https://github.com/qtile/qtile.git
cd qtile
sudo python3 setup.py install
cd ..
sudo cp ./debian/qtile.desktop /usr/share/xsessions
# install kitty terminal
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
pip install pyxdg
sudo ln -s ~/.local/kitty.app/bin/kitty /usr/local/bin

#base pyenv setup
pyenv install 3.11.4
pyenv global 3.11.4

#base goenv setup
goenv install 1.20.5
goenv global 1.20.5

#base npm setup
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
zsh nvm install 9.8

# do samba join?
# mkdir ~/nas
# vim ~/.smbcredentials
# sudo mount -t cifs -o x-systemd.automount,noauto,x-systemd.after=network-online.target,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,credentials=/home/denial/.smbcredentials,uid=1000,gid=100 //home.denial.lan/denial /home/denial/nas
# sudo systemctl daemon-reload

sudo apt autoremove
