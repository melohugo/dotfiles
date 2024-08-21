#!/usr/bin/env bash

#Configure a hostname
read -p "Give a hostname: " hostName
sudo hostnamectl set-hostname $hostName

sudo dnf -y update

# rpm fusion
sudo dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y update @core

sudo dnf -y install gnome-tweak-tool dconf-editor

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo dnf -y curl

# Install nerd fonts
git clone --depth=1 https://github.com/terroo/fonts
cd fonts
mv fonts ~/.local/share
fc-cache -fv
cd ..

# Terminal
sudo dnf -y install alacritty
curl -sS https://starship.rs/install.sh | sh
sudo dnf -y install vim neovim tmux
sudo dnf -y install htop sl neofetch

# Install useful apps
sudo dnf -y install telegram discord vlc
flatpak install flathub com.github.marktext.marktext # Install marktext
flatpak install flathub com.obsproject.Studio

# Install codecs
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video

# Install dev tools
sudo dnf -y groupinstall 'Development Tools'
sudo dnf -y groupinstall 'C Development Tools and Libraries'
sudo dnf -y install docker docker-compose
flatpak install flathub rest.insomnia.Insomnia

# Install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
echo '# ASDF' >> ~/.bashrc
echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc
echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc

sudo dnf -y install unzip p7zip p7zip-plugins unrar

########################################
#              Setting                 #
########################################

# Configure alacritty
mkdir ~/.config/alacritty/
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
cp alacritty.toml ~/.config/alacritty/alacritty.toml

# Configure starship
echo '# Starship' >> ~/.bashrc
echo 'eval "$(starship init bash)"' >> ~/.bashrc
cp starship.toml ~/.config/starship.toml

# Configure neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
cp -r nvim/ ~/.config/nvim

# Configure tmux
cp .tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
