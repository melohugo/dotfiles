# Aliases
alias aider-qwen='ai-jail aider --model ollama/qwen2.5-coder:7b --suggest-shell-commands'
alias prolog='flatpak run org.swi_prolog.swipl'
alias lzd='lazydocker'
alias lg='lazygit'

# Eza aliases
if command -v eza > /dev/null; then
  alias ls='eza --icons'
  alias ll='eza -lh --icons'
  alias la='eza -lah --icons'
  alias lt='eza --tree --level=2 --icons'
fi
