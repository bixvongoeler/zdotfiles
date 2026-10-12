# --- Terminal Integration --- #
# iTerm2 ("Load shell integration automatically") and Ghostty inject their
# own shell integration, so only VS Code is wired up here.
if [[ ${TERM_PROGRAM:l} == vscode ]]; then
    # https://code.visualstudio.com/docs/terminal/shell-integration
    MY_HISTFILE=${HISTFILE:-${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history}
    source "$(code --locate-shell-integration-path zsh)"
    HISTFILE=$MY_HISTFILE
    #unset MY_HISTFILE
fi

# 24-bit color: iTerm2 sets COLORTERM, but ssh doesn't forward it. iTerm2's
# LC_TERMINAL does reach hosts whose sshd accepts LC_* (the OrbStack VM).
if [[ -z $COLORTERM && ( $LC_TERMINAL == iTerm2 || $TERM == xterm-ghostty ) ]]; then
    export COLORTERM=truecolor
fi

# Clipboard over ssh, on hosts without a pbcopy of their own (OrbStack has
# one): OSC 52, which iTerm2 accepts with "Applications in terminal may
# access clipboard" on. Inside tmux this needs `set -g set-clipboard on`.
if [[ -n $SSH_CONNECTION ]] && (( ! $+commands[pbcopy] )); then
    pbcopy() {
        printf '\e]52;c;%s\a' "$(base64 | tr -d '\n')" > /dev/tty
    }
fi
