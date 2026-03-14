# Configurações Pessoais para Fedora

Este repositório contém minhas configurações pessoais para ferramentas como Alacritty, tmux, Starship, e nvim, além de um script para automatizar a instalação dessas configurações e outras dependências essenciais após a instalação do Fedora.

## Estrutura do Repositório

- `alacritty.toml`: Configurações do Alacritty
- `.tmux.conf`: Configurações do tmux
- `starship.toml`: Configurações do Starship
- `nvim/`: Configurações do Neovim
- `install.sh`: Script para aplicar todas as configurações e instalar dependências

## Pré-requisitos

Certifique-se de ter o Git e o make instalado. Você pode instalar o Git e o make usando o seguinte comando:

```bash
sudo dnf install git make
```

## Como usar

Primeiro, clone o repositório para o seu diretório pessoal:

```bash
git clone https://github.com/melohugo/dotfiles.git
cd dotfiles
```

Utilize o make para configurar tudo com esse comando:

```bash
make install
```
