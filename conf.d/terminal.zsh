# --- Terminal Integration --- #

case "${TERM_PROGRAM:l}" in
ghostty)
    source ${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration
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

# Windows Terminal Integration
if [[ -n "$WT_SESSION" ]]; then
  autoload -Uz add-zsh-hook

  # Runs before the prompt is drawn (Idle state)
  function _wt_tab_title_precmd() {
    # Set title to current directory (%~ expands to user-relative path)
    print -Pn "\e]0;%~\a"
  }

  # Runs before a command is executed (Running state)
  function _wt_tab_title_preexec() {
    # Set title to the command line string ($1)
    # -n: do not print newline
    # -r: raw output (escapes in the command name won't be interpreted)
    print -nr $'\e]0;'"$1"$'\a'
  }

  add-zsh-hook precmd _wt_tab_title_precmd
  add-zsh-hook preexec _wt_tab_title_preexec
fi

export COLORTERM=truecolor
