#
# __init__: This runs prior to any other conf.d contents.
#

# Apps
export EDITOR="zed --wait"
export VISUAL="zed --wait"
export PAGER=less
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
export MANROFFOPT="-c"   # avoids overstrike artifacts in recent groff

# Auto-deduplicate PATH entries
typeset -U path

# Set the list of directories that cd searches.
cdpath=(
    $XDG_PROJECTS_DIR(N/)
    $cdpath
)

# Set the list of directories that Zsh searches for programs.
path=(
    $HOME/.local/bin(N)
    $HOME/.cargo/bin(N)
    $path
)
