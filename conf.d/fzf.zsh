# fzf
# A git install in ~/.fzf wins over the system fzf (Ubuntu's apt fzf, 0.44,
# is too old for `fzf --zsh`).
path=($HOME/.fzf/bin(N) $path)

# Key bindings (^T, ^R, ⌥C) and ** completion: terminal sessions only (see
# _zsh_tty in .zshrc), and only with an fzf that supports --zsh (0.48+).
if [[ -n $_zsh_tty ]] && (( $+commands[fzf] )) && _fzf_init=$(fzf --zsh 2>/dev/null); then
    eval "$_fzf_init"
fi
unset _fzf_init

export FZF_DEFAULT_COMMAND="fd -HI --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
