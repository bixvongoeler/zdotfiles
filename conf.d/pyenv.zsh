#
# pyenv: Python version + virtualenv management
#
# All pyenv setup lives here (sourced by .zshrc for every interactive shell)
# rather than in .zprofile. .zprofile only runs for *login* shells, so a
# non-login interactive terminal would reach `pyenv virtualenv-init` before
# pyenv was ever placed on PATH -> "command not found: pyenv" at startup.
#
# Order: virtualenv-init must come after `pyenv init`, and both need
# $PYENV_ROOT/bin on PATH first.
#

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && path=("$PYENV_ROOT/bin" $path)

if (( $+commands[pyenv] )); then
    eval "$(pyenv init - zsh)"
    eval "$(pyenv virtualenv-init -)"
fi
