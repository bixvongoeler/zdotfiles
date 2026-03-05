#
# .zshrc - runs only for interactive shells
#

# --- Profiling (opt-in: run `zprofrc` to launch a profiled shell) --- #
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Init Powerlevel10k (Needs to happen first)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Define Zsh Locations
ZSH_CONFIG_DIR="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"
ZSH_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p $ZSH_CONFIG_DIR $ZSH_DATA_DIR $ZSH_CACHE_DIR

# Set Zsh Options
setopt EXTENDED_GLOB INTERACTIVE_COMMENTS

# --- Custom Completions --- #
fpath=($ZSH_CONFIG_DIR/completions $fpath)

# --- Autoload Functions --- #
# Each file in functions/ becomes a lazy-loaded function (loaded on first call)
for _fndir in $ZSH_CONFIG_DIR/functions(/FN) $ZSH_CONFIG_DIR/functions/*(/FN); do
    fpath=($_fndir $fpath)
    autoload -Uz $_fndir/*~*/_*(N.:t)
done
unset _fndir

# --- Zinit Plugin Manager --- #
source $ZSH_CONFIG_DIR/lib/zinit.zsh

# --- Source conf.d --- #
# Each file handles one concern: aliases, history, keybindings, tools, etc.
# Prefix a filename with ~ to disable it without deleting.
for _rc in $ZSH_CONFIG_DIR/conf.d/*.zsh(N); do
    [[ "${_rc:t}" != '~'* ]] || continue
    source "$_rc"
done
unset _rc

# --- Local Overrides (machine-specific, gitignored) --- #
[[ ! -r $ZSH_CONFIG_DIR/.zshrc.local ]] || source $ZSH_CONFIG_DIR/.zshrc.local

# --- Profiling Cleanup --- #
[[ "$ZPROFRC" -eq 1 ]] && zprof
[[ -v ZPROFRC ]] && unset ZPROFRC

true
