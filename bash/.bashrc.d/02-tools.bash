# ASDF
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
  . "$HOME/.asdf/completions/asdf.bash"
fi

# Starship
if command -v starship > /dev/null; then
  eval "$(starship init bash)"
fi

# Zoxide
if command -v zoxide > /dev/null; then
  eval "$(zoxide init bash)"
fi

# Fuzzy Finder key bindings
if [ -f /usr/share/fzf/shell/key-bindings.bash ]; then
  #source /usr/share/fzf/shell/completion.bash
  source /usr/share/fzf/shell/key-bindings.bash
fi
