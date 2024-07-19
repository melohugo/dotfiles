#!/usr/bin/env bash

#Configure a hostname
read -p "Give a hostname: " hostName
sudo hostnamectl set-hostname $hostName

# Configure dnf for more speed
dnfConfig="
# Added for speed
fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True"

sudo echo "$dnfConfig" >> /etc/dnf/dnf.conf

sudo -y dnf update

# rpm fusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf update @core

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

# Install dev tools
sudo dnf groupinstall 'Development Tools' && dnf groupinstall 'C Development Tools and Libraries'
sudo dnf -y install docker docker-compose
flatpak install flathub com.getpostman.Postman

# Install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
echo '# ASDF' >> ~/.bashrc
echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc
echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc

# Install CUDA toolkit 
wget https://developer.download.nvidia.com/compute/cuda/12.5.1/local_installers/cuda-repo-fedora39-12-5-local-12.5.1_555.42.06-1.x86_64.rpm
sudo rpm -i cuda-repo-fedora39-12-5-local-12.5.1_555.42.06-1.x86_64.rpm
sudo dnf clean all
sudo dnf -y install cuda-toolkit-12-5
sudo dnf -y module install nvidia-driver:open-dkms # Install driver

sudo dnf -y install java-openjdk icedtea-web
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
