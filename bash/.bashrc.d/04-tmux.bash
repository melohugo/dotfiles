# ==============================================================================
# 04-tmux.bash: Integração e automação de desenvolvimento com Tmux
# ==============================================================================

# Wrapper inteligente para o comando tmux
tmux() {
  if [ "$1" = "dev" ]; then
    tmux-sessionizer .
    return $?
  fi

  command tmux "$@"
}
