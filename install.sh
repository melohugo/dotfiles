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
flatpak update

sudo dnf -y install curl

sudo dnf -y install dnf-plugins-core

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
sudo dnf -y install htop sl neofetch cmatrix cowsay bat fd-find fzf zoxide stow bc wl-clipboard ripgrep eza
sudo dnf -y copr enable atim/lazygit
sudo dnf -y install lazygit

# Install useful apps
sudo dnf -y install telegram discord vlc steam
flatpak install flathub com.github.marktext.marktext # Install marktext
flatpak install flathub com.obsproject.Studio
flatpak install flathub com.visualstudio.code

# Install codecs
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video

# Install dev tools
sudo dnf -y groupinstall 'Development Tools'
sudo dnf -y groupinstall 'C Development Tools and Libraries'
flatpak install flathub rest.insomnia.Insomnia
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# Install asdf
if [ ! -d "$HOME/.asdf" ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.18.1
fi

# Load ASDF for this script session
. "$HOME/.asdf/asdf.sh"

# Install Lazydocker
asdf plugin add lazydocker https://github.com/comdotlinux/asdf-lazydocker.git || true
asdf install lazydocker latest
asdf global lazydocker latest

sudo dnf -y install unzip p7zip p7zip-plugins unrar

########################################
#              Setting                 #
########################################

# Creating files to run Stow
mkdir -p ~/.config/alacritty/
mkdir -p ~/.config/nvim/
mkdir -p ~/.bashrc.d/

# Linking configuration files
PACKAGES=(nvim alacritty starship tmux bash)

for pkg in "${PACKAGES[@]}"; do
    echo "Installing $pkg config"
    stow $pkg
done

# Theme of alacritty
if [ ! -d ~/.config/alacritty/themes ]; then
    git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
fi

# TPM for tmux
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
# Install plugins automatically
~/.tmux/plugins/tpm/bin/install_plugins
