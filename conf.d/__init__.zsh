#
# __init__: This runs prior to any other conf.d contents.
#

# Apps
export EDITOR="zed-preview --wait"
export VISUAL="zed-preview --wait"
export PAGER=less

# Misc exports
export TESSDATA_PREFIX=$HOMEBREW_PREFIX/share/tessdata/

# Auto-deduplicate PATH entries
typeset -U path

# Set the list of directories that cd searches.
cdpath=(
    # $XDG_PROJECTS_DIR(N/)
    # $HOME/tufts_dev(N/)
    $cdpath
)

# Set the list of directories that Zsh searches for programs.
path=(
    $HOME/.local/bin(N)
    $HOME/.cargo/bin(N)
    $HOMEBREW_PREFIX/opt/rustup/bin(N)
    $HOMEBREW_PREFIX/opt/llvm/bin(N)

    $path

    $HOME/.platformio/packages/toolchain-gccarmnoneeabi/bin(N)
    $HOME/.platformio/penv/bin(N)
    $HOMEBREW_PREFIX/opt/curl/bin(N)
    $HOMEBREW_PREFIX/opt/go/libexec/bin(N)
    $HOMEBREW_PREFIX/share/npm/bin(N)
)
