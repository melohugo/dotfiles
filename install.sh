#!/usr/bin/env bash

set -e

# ==============================================================================
# Hostname (opcional, seguro para máquinas corporativas)
# ==============================================================================
read -p "Give a hostname (leave blank to keep current): " hostName
if [ -n "$hostName" ]; then
    sudo hostnamectl set-hostname "$hostName"
fi

# ==============================================================================
# Sistema & Repositórios
# ==============================================================================
sudo dnf -y update

# RPM Fusion (Free e Nonfree)
sudo dnf -y install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y update @core

# GNOME Tweaks e dconf
sudo dnf -y install gnome-tweaks dconf-editor

# Pacotes essenciais de sistema
sudo dnf -y install curl dnf-plugins-core

# Flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak update -y

# ==============================================================================
# Fontes (Nerd Fonts)
# ==============================================================================
if [ ! -d "$HOME/.local/share/fonts" ] || [ -z "$(ls -A "$HOME/.local/share/fonts" 2>/dev/null)" ]; then
    echo "Installing nerd fonts..."
    TMP_FONTS=$(mktemp -d)
    git clone --depth=1 https://github.com/terroo/fonts "$TMP_FONTS"
    mkdir -p "$HOME/.local/share/fonts"
    cp -r "$TMP_FONTS/fonts/"* "$HOME/.local/share/fonts/" 2>/dev/null || cp -r "$TMP_FONTS/"* "$HOME/.local/share/fonts/"
    fc-cache -fv
    rm -rf "$TMP_FONTS"
fi

# ==============================================================================
# Terminal & Utilitários CLI
# ==============================================================================
sudo dnf -y install alacritty

if ! command -v starship > /dev/null 2>&1; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

sudo dnf -y install vim neovim tmux
sudo dnf -y install htop sl fastfetch cmatrix cowsay bat fd-find fzf zoxide stow bc wl-clipboard ripgrep eza tree

# Lazygit via Copr
sudo dnf -y copr enable atim/lazygit
sudo dnf -y install lazygit

# ==============================================================================
# Assistentes de IA (Antigravity CLI & Claude Code)
# ==============================================================================
mkdir -p "$HOME/.local/bin"

if ! command -v agy > /dev/null 2>&1; then
    echo "Installing Antigravity CLI (agy)..."
    curl -fsSL https://antigravity.google/cli/install.sh | bash
fi

if ! command -v claude > /dev/null 2>&1; then
    echo "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
fi

# ==============================================================================
# Aplicativos (Desktop & GUI)
# ==============================================================================
sudo dnf -y install telegram discord vlc steam

flatpak install -y flathub com.github.marktext.marktext
flatpak install -y flathub com.obsproject.Studio
flatpak install -y flathub rest.insomnia.Insomnia

# ==============================================================================
# Codecs Multimídia
# ==============================================================================
sudo dnf -y swap ffmpeg-free ffmpeg --allowerasing
sudo dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf -y groupupdate sound-and-video

# ==============================================================================
# Ferramentas de Desenvolvimento e Dependências de Compilação
# ==============================================================================
sudo dnf -y groupinstall 'Development Tools' 'C Development Tools and Libraries'
sudo dnf -y install gcc gcc-c++ make zlib-devel bzip2-devel readline-devel sqlite-devel openssl-devel xz-devel libffi-devel tk-devel ncurses-devel

# Docker CE
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

# ==============================================================================
# Gerenciador de Versões (ASDF) & Lazydocker
# ==============================================================================
if [ ! -d "$HOME/.asdf" ]; then
    git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.15.0
fi

# Carrega ASDF nesta sessão
. "$HOME/.asdf/asdf.sh"

asdf plugin add lazydocker https://github.com/comdotlinux/asdf-lazydocker.git || true
asdf install lazydocker latest || true
asdf global lazydocker latest || true

# Compactadores
sudo dnf -y install unzip p7zip p7zip-plugins unrar

# ==============================================================================
# Configurações & Dotfiles (GNU Stow)
# ==============================================================================
mkdir -p "$HOME/.config/alacritty"
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.bashrc.d"
mkdir -p "$HOME/.local/bin"

PACKAGES=(nvim alacritty starship tmux bash)

for pkg in "${PACKAGES[@]}"; do
    echo "Restowing $pkg config..."
    stow -R "$pkg"
done

# Tema do Alacritty
if [ ! -d "$HOME/.config/alacritty/themes" ]; then
    git clone https://github.com/alacritty/alacritty-theme "$HOME/.config/alacritty/themes"
fi

# TPM (Tmux Plugin Manager)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Instalação automática dos plugins do Tmux
if [ -f "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
    "$HOME/.tmux/plugins/tpm/bin/install_plugins"
fi

echo "========================================="
echo " Instalação e configuração concluídas!  "
echo "========================================="
