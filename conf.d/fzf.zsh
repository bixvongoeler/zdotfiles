# fzf
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND="fd -HI --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
