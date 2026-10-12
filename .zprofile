#
# .zprofile - runs second for login shells
#
# Login shells: terminal windows, ssh sessions, tmux panes, and Zed reading
# the environment. Machine-specific settings go in .zprofile.local.
#

if [[ $OSTYPE == darwin* ]]; then
    # Homebrew shell environment
    [[ ! -x /opt/homebrew/bin/brew ]] || eval "$(/opt/homebrew/bin/brew shellenv)"

    # OrbStack: command-line tools and integration (added by its installer)
    [[ ! -r ~/.orbstack/shell/init.zsh ]] || source ~/.orbstack/shell/init.zsh
fi

# pyenv shims for login shells that never read .zshrc; the full setup is in
# conf.d/pyenv.zsh
[[ ! -d ${PYENV_ROOT:-$HOME/.pyenv}/shims ]] || path=(${PYENV_ROOT:-$HOME/.pyenv}/shims $path)

# Load secret environment variables (gitignored)
[[ ! -r $ZDOTDIR/.zsecret ]] || source $ZDOTDIR/.zsecret

# Machine-specific login settings (gitignored)
[[ ! -r $ZDOTDIR/.zprofile.local ]] || source $ZDOTDIR/.zprofile.local
