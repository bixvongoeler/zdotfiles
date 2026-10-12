#
# __init__: This runs prior to any other conf.d contents.
#

# Auto-deduplicate PATH entries
typeset -U path

# Set the list of directories that cd searches.
cdpath=(
    # $XDG_PROJECTS_DIR(N/)
    # $HOME/tufts_dev(N/)
    $cdpath
)

# Set the list of directories that Zsh searches for programs.
# (N) drops entries that don't exist on this machine.
path=(
    $HOME/.local/bin(N)
    $HOME/.cargo/bin(N)
    $HOMEBREW_PREFIX/opt/rustup/bin(N)
    $HOMEBREW_PREFIX/opt/llvm/bin(N)
    $HOMEBREW_PREFIX/opt/curl/bin(N)

    $path

    $HOME/.platformio/packages/toolchain-gccarmnoneeabi/bin(N)
    $HOME/.platformio/penv/bin(N)
    $HOMEBREW_PREFIX/opt/go/libexec/bin(N)
    $HOMEBREW_PREFIX/share/npm/bin(N)
)

# Apps: Zed on the Mac itself, nano over ssh and on Linux
if [[ -z $SSH_CONNECTION ]] && (( $+commands[zed-preview] )); then
    export EDITOR="zed-preview --wait"
else
    export EDITOR=nano
fi
export VISUAL=$EDITOR

# bat as pager, man pager and theme wherever it's installed
# (Debian and Ubuntu install it as batcat)
if (( $+commands[bat] || $+commands[batcat] )); then
    (( $+commands[bat] )) || alias bat=batcat
    _bat=${${commands[bat]:+bat}:-batcat}
    export PAGER="$_bat -p"
    export BAT_PAGER=less    # bat's own paging (never bat itself)
    export MANPAGER="sh -c 'col -bx | $_bat -l man -p'"
    export MANROFFOPT="-c"   # avoids overstrike artifacts in recent groff
    export BAT_THEME=OneHalfDark
    unset _bat
else
    export PAGER=less
fi

# Misc exports
[[ -z $HOMEBREW_PREFIX ]] || export TESSDATA_PREFIX=$HOMEBREW_PREFIX/share/tessdata/
