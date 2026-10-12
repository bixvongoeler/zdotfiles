#
# .zshenv - runs for ALL shells (login, interactive, scripts)
#
# This is the bootstrapper: ~/.zshenv is a symlink to this file. Its only
# job is to set ZDOTDIR and the XDG variables so everything else can live
# under ~/.config/zsh. It runs for every script too: keep it fast and silent.
#
# New machine: ln -s ~/.config/zsh/.zshenv ~/.zshenv
#

# XDG Base Directories
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/dev}

# Set ZDOTDIR so zsh looks for all other dotfiles here
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

if [[ $OSTYPE == darwin* ]]; then
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
    # macOS has no XDG_RUNTIME_DIR; 1Password's op daemon and yazi keep
    # sockets here. On Linux systemd provides /run/user/$UID: leave it alone.
    export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}
    [[ -d $XDG_RUNTIME_DIR ]] || mkdir -m 700 -p -- $XDG_RUNTIME_DIR
fi

# Ubuntu's /etc/zsh/zshrc runs compinit unless this is set; zinit runs it.
skip_global_compinit=1

# Ensure directories exist
() {
    local zdir
    for zdir in $@; do
        [[ -d "${(P)zdir}" ]] || mkdir -p -- "${(P)zdir}"
    done
} XDG_{CONFIG,CACHE,DATA,STATE}_HOME XDG_PROJECTS_DIR

# Machine-specific settings for every shell (gitignored)
[[ ! -r $ZDOTDIR/.zshenv.local ]] || source $ZDOTDIR/.zshenv.local
