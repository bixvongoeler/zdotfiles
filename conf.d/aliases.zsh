# --- Aliases --- #
if (( $+commands[lsd] )); then
    alias l='lsd'
    alias ls='lsd'
    alias la='lsd -A'
    alias lla='lsd -la --ignore-config'
    alias lt='lsd --tree --depth 2'
    alias ltd='lsd --tree --depth 3 -d'
    alias lsl='lsd --blocks=date,size,name'
    alias lss='lsd --blocks=name,size | sort'
fi

(( ! $+commands[nvim] )) || alias vim='nvim'
alias c='clear'
alias n='nano'
alias gs='git status'

# --- Utility --- #
alias comp-clear='rm -f $ZDOTDIR/.zcompdump* && exec zsh'

# --- Named Directories --- #
