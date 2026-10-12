# Fuzzy-pick a directory in ~/.config, then cd into it and ls
cd_config() {
    local base=$HOME/.config
    local dir
    dir=$(print -rl -- $base/*(N-/:t) |
        fzf --height=40% --reverse --prompt='~/.config/ ' \
            --preview="eza -1 --color=always --group-directories-first $base/{}")

    if [[ -z $dir ]]; then # Esc / Ctrl-C: leave the line untouched
        zle reset-prompt
        return
    fi

    zle push-line # save whatever you'd typed so far
    BUFFER="cd ~/.config/${(q)dir} && ls"
    zle accept-line
}
zle -N cd_config
bindkey '^O' cd_config
