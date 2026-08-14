#
# .zshenv - runs for ALL shells (login, interactive, scripts)
#
# This is the bootstrapper. It lives at ~/.zshenv and its only
# job is to set ZDOTDIR and XDG variables so everything else
# can live under ~/.config/zsh.
#

# XDG Base Directories
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}
export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/dev}

# Set ZDOTDIR so zsh looks for all other dotfiles here
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

# Ensure directories exist
() {
    local zdir
    for zdir in $@; do
        [[ -d "${(P)zdir}" ]] || mkdir -p -- "${(P)zdir}"
    done
} XDG_{CONFIG,CACHE,DATA,STATE}_HOME XDG_{RUNTIME,PROJECTS}_DIR
