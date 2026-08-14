#
# .zshenv - runs second for login shells
#
# note: using .zprofile for machine specific configuration
#

# Load secret environment variables
test -e $ZDOTDIR/.zsecret && source $ZDOTDIR/.zsecret

# Set for zsh-autocomplete when using Ubuntu
export skip_global_compinit=1

# Cargo's bin dir is already added to PATH in conf.d/__init__.zsh (for all
# interactive shells), so sourcing ~/.cargo/env here would be redundant.

# Homebrew shell environment
# eval "$(/opt/homebrew/bin/brew shellenv)"

# Pyenv setup lives in conf.d/pyenv.zsh so it runs for non-login shells too
# (a terminal that opens a non-login shell never sources this .zprofile).
