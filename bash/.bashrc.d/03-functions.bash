# 1. Abre arquivos no Neovim (Melhorado para respeitar FZF_DEFAULT_COMMAND)
v() {
  local file
  file=$(fzf --query="$1" --preview 'bat --style=numbers --color=always --line-range :500 {}')
  [ -n "$file" ] && nvim "$file"
}

# 2. Navega em diretórios usando eza --tree para um preview muito mais elegante
cf() {
  local dir
  dir=$(fd --type d --hidden --exclude .git | fzf --query="$1" --preview 'eza --tree --level=2 --color=always {} | head -100')
  [ -n "$dir" ] && cd "$dir"
}

# 3. Busca Interativa por Conteúdo (RipGrep + FZF + Bat)
# Digite 'fif' para buscar texto dentro de qualquer arquivo do diretório atual em tempo real.
# Pressionar ENTER abre o Neovim exatamente na linha onde o termo foi encontrado!
fif() {
  local file_line
  file_line=$(FZF_DEFAULT_COMMAND="" fzf --ansi --disabled \
    --query "$1" \
    --bind "change:reload(rg --line-number --no-heading --color=always --smart-case {q} || true)" \
    --preview 'file=$(echo {} | cut -d: -f1); line=$(echo {} | cut -d: -f2); [ -f "$file" ] && bat --color=always --highlight-line "$line" "$file" || echo "Digite algo para buscar..."' \
    --preview-window 'right:60%:border-left,+{2}-10')

  if [ -n "$file_line" ]; then
    local file=$(echo "$file_line" | cut -d: -f1)
    local line=$(echo "$file_line" | cut -d: -f2)
    nvim "+$line" "$file"
  fi
}

# 4. Extrator Universal (Descompacta qualquer arquivo com um comando simples)
# Uso: ex arquivo.zip ou ex arquivo.tar.gz
ex() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' não pôde ser extraído via ex()" ;;
    esac
  else
    echo "'$1' não é um arquivo válido"
  fi
}

# 5. Cria e Entra na pasta automaticamente
mkd() {
  mkdir -p "$1" && cd "$1"
}
