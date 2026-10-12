#
# selftest-checks.zsh - sourced by scripts/zsh-selftest inside the shell
# under test. Appends key=value lines to the file named by $1, and binds ^X^T
# to a widget that appends the line editor state (dump:N=CURSOR|BUFFER), so
# the driver can send real keystrokes and see what they did.
#

typeset -g _zst_out=${1:?usage: source selftest-checks.zsh OUTFILE}
typeset -gi _zst_n=0

_zst_dump() { print -r -- "dump:$(( ++_zst_n ))=$CURSOR|$BUFFER" >> $_zst_out }
zle -N _zst_dump
bindkey -M emacs '^X^T' _zst_dump

() {
    emulate -L zsh
    local k v
    local -a colors
    local -aU upath=($path)
    {
        print -r -- "os=$OSTYPE"
        print -r -- "ssh=${SSH_CONNECTION:+1}"
        print -r -- "keymap=$(bindkey -lL main)"
        for k in '^R' '^T' '^[c' '^O' '^I' '^[b' '^[f' '^A' '^E' '^[[1;3D' '^[[1;3C' \
                 '^[[1;5D' '^[[1;5C' '^H' '^[^?' '^U' '^P' '^N'; do
            v=$(bindkey -M emacs -- $k)
            print -r -- "bind:$k=${v##* }"
        done
        print -r -- "plugins=${(j: :)${(o)ZINIT_REGISTERED_PLUGINS}}"
        for v in p10k fzf-tab-complete _zsh_autosuggest_start _zsh_highlight colored ofd \
                 fzf-history-widget z zi pbcopy; do
            print -r -- "fn:$v=$+functions[$v]"
        done
        zstyle -a ':completion:*' list-colors colors
        print -r -- "list-colors=${#colors}"
        for v in l ls la lla lt ltd lsl lss gs n c vim bat z gld gln zedit fif y cd_config; do
            print -r -- "whence:$v=${$(whence -w $v)#*: }"
        done
        for v in EDITOR VISUAL PAGER BAT_PAGER BAT_THEME MANPAGER LESS LESSHISTFILE COLORTERM \
                 LANG LC_ALL TERM ZDOTDIR TMPDIR XDG_STATE_HOME XDG_RUNTIME_DIR HISTFILE \
                 skip_global_compinit; do
            print -r -- "env:$v=${(P)v-<unset>}"
        done
        print -r -- "path=${(j.:.)path}"
        print -r -- "path-dups=$(( $#path - $#upath ))"
        print -r -- "direnv-hooks=${#${(M)precmd_functions:#_direnv_hook}}"
        for v in lsd eza bat batcat fd fdfind fzf zoxide nvim nano direnv pyenv zed-preview pbcopy; do
            print -r -- "cmd:$v=${commands[$v]:-}"
        done
        print -r -- "fzf-version=${$(fzf --version 2>/dev/null)%% *}"
    } >> $_zst_out
}
