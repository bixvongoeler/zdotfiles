#
# pyenv: Python version + virtualenv management
#
# The full setup lives here (sourced by .zshrc for every interactive shell)
# rather than in .zprofile. .zprofile only runs for *login* shells, so a
# non-login interactive terminal would reach `pyenv virtualenv-init` before
# pyenv was ever placed on PATH -> "command not found: pyenv" at startup.
# .zprofile still adds the shims, for login shells that never read .zshrc.
#
# Order: virtualenv-init must come after `pyenv init`, and both need
# $PYENV_ROOT/bin on PATH first. No pyenv (NixOS, the VM): nothing happens.
#

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && path=("$PYENV_ROOT/bin" $path)

if (( $+commands[pyenv] )); then
    eval "$(pyenv init - --no-rehash zsh)"
    # pyenv-virtualenv is optional (not installed on the Mac)
    if (( $+commands[pyenv-virtualenv-init] )) || [[ -d $PYENV_ROOT/plugins/pyenv-virtualenv ]]; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi
