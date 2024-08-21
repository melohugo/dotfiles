# Configurações Pessoais para Fedora

Este repositório contém minhas configurações pessoais para ferramentas como Alacritty, tmux, Starship, e nvim, além de um script para automatizar a instalação dessas configurações e outras dependências essenciais após a instalação do Fedora.

## Estrutura do Repositório

- `alacritty.toml`: Configurações do Alacritty
- `.tmux.conf`: Configurações do tmux
- `starship.toml`: Configurações do Starship
- `nvim/`: Configurações do Neovim
- `install.sh`: Script para aplicar todas as configurações e instalar dependências

## Pré-requisitos

Certifique-se de ter o Git instalado. Você pode instalar o Git usando o seguinte comando:

```bash
sudo dnf install git
```

## Como usar

Primeiro, clone o repositório para o seu diretório pessoal:

```bash
git clone https://github.com/melohugo/dotfiles.git
cd dotfiles
```

Para deixar o dnf mais rapido cole

fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True

em 

/etc/dnf/dnf.conf

Utilize o make para dar permissão de execução ao script install.sh

```bash
make install
```

execute o script install.sh

```bash
./install.sh
```

