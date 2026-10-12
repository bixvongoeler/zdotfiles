# --- fzf-tab: `zed <dir>` -> `zed -n <dir>` --- #
# After a Tab completion, if the command is zed/zed-preview and any argument is
# a directory, insert `-n` so the folder opens in a new window. Skipped if a
# window flag (-n/-a/-e and long forms) is already present.
# Wraps fzf-tab's public widget only; sourced from fzf-tab's zinit atload so the
# Tab rebinding happens after fzf-tab binds Tab itself.

whence -w fzf-tab-complete >/dev/null || return

# Enter in the zed/zed-preview box selects AND runs the command (fzf-tab's
# documented accept-line zstyle). fzf-tab calls `.accept-line` inside
# fzf-tab-complete, but zle only executes the line once the outermost widget
# returns, so the -n rewrite below still lands before the command runs.
# Only applies when the fzf box was shown: single-match and common-prefix
# completions insert text as usual without running anything.
zstyle ':fzf-tab:complete:(zed|zed-preview):*' accept-line enter

# Rewrite LBUFFER in place; returns 0 only if it inserted -n.
# Split out of the widget so it can be tested alone.
_ftb_zed_add_new() {
    emulate -L zsh -o extended_glob
    local -a words=(${(z)LBUFFER})
    local w p
    [[ $words[1] == (zed|zed-preview) ]] || return 1
    (( ${words[(I)(-n|--new|-a|--add|-e|--existing)]} )) && return 1
    for w in $words[2,-1]; do
        p=${(Q)w}
        p=${p/#\~/$HOME}
        if [[ $p != -* && -d $p ]]; then
            LBUFFER=${LBUFFER/$words[1]/$words[1] -n}
            return 0
        fi
    done
    return 1
}

# Keep zsh-autosuggestions from wrapping this widget. Its wrapper saves the
# suggestion shown before Tab (e.g. `--help` from `zed --help` in history) and
# can restore it after the buffer changed, leaving a stale ghost suggestion.
# fzf-tab-complete itself is still wrapped, so suggestions keep working.
typeset -ga ZSH_AUTOSUGGEST_IGNORE_WIDGETS
ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(fzf-tab-zed-complete)

fzf-tab-zed-complete() {
    zle fzf-tab-complete
    local ret=$?
    # After inserting -n, any suggestion is for the old buffer: drop it.
    _ftb_zed_add_new && POSTDISPLAY=
    return ret
}
zle -N fzf-tab-zed-complete

bindkey -M emacs '^I' fzf-tab-zed-complete
bindkey -M viins '^I' fzf-tab-zed-complete
