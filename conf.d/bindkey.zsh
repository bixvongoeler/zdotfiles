# --- Keybindings --- #
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# bindkey "\033f" forward-word
# bindkey "\033b" backward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;3D' beginning-of-line
bindkey '^[[1;3C' end-of-line
# ctrl-backspace delete word
bindkey '^H' backward-kill-word
