# --- History Config --- #

HISTSIZE=25000
HISTFILE=$ZSH_CONFIG_DIR/.zsh_history
SAVEHIST=$HISTSIZE

setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
