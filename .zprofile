#
# .zprofile - runs second for login shells
#
# note: using .zprofile for machine specific configuration
#

# Homebrew shell environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# Setup Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - --no-rehash zsh)"

# Load secret environment variables
# test -e $ZDOTDIR/.zsecret && source $ZDOTDIR/.zsecret
[[ -r $ZDOTDIR/.zsecret ]] && source $ZDOTDIR/.zsecret

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
