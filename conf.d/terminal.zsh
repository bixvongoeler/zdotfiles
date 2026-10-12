# --- Terminal Integration --- #

case "${TERM_PROGRAM:l}" in
ghostty)
    # source ${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration
    ;;
iTerm.app)
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
    ;;
vscode)
    # https://code.visualstudio.com/docs/terminal/shell-integration
    MY_HISTFILE=${HISTFILE:-${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history}
    source "$(code --locate-shell-integration-path zsh)"
    HISTFILE=$MY_HISTFILE
    #unset MY_HISTFILE
    ;;
esac
