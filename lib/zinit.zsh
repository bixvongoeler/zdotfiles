#!/bin/zsh
#
# zinit.zsh - Zinit plugin manager setup
#
# Handles bootstrapping zinit, loading the prompt theme,
# and declaring all plugins (most in turbo mode).
#

# --- Bootstrap Zinit --- #
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# --- OMZ Plugin Fix --- #
# Workaround for zinit issue#504: removes subversion dependency for OMZ snippets.
# The function must be available before zinit loads any OMZP:: plugins.
source $ZSH_CONFIG_DIR/lib/_fix-omz-plugin.zsh

# --- Prompt (loaded immediately, not turbo) --- #
zinit ice depth=1
zinit light romkatv/powerlevel10k

# --- LS_COLORS --- #
# coreutils' dircolors is called gdircolors under Homebrew
(( ! $+commands[gdircolors] )) || alias dircolors='gdircolors'
zinit ice atclone"${${commands[gdircolors]:+gdircolors}:-dircolors} -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'
zinit light trapd00r/LS_COLORS
typeset -g ZSH_HIGHLIGHT_MAXLENGTH=300

# --- Turbo-loaded Plugins --- #
# These load after the prompt is drawn (wait = after first prompt).
zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay; _comp_options+=(globdots)" \
    zdharma-continuum/fast-syntax-highlighting \
    atclone"_fix-omz-plugin" \
    OMZP::colored-man-pages \
    if'[[ $OSTYPE == darwin* ]]' \
    OMZP::macos \
    blockf \
    zsh-users/zsh-completions \
    atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit ice wait lucid atload'source $ZSH_CONFIG_DIR/lib/fzf-tab-icons.zsh; source $ZSH_CONFIG_DIR/lib/fzf-tab-zed.zsh'
zinit light Aloxaf/fzf-tab

# ^R is fzf's history search (conf.d/fzf.zsh)

# Config p10k if not already configured
[[ ! -f $ZSH_CONFIG_DIR/.p10k_config.zsh ]] || source $ZSH_CONFIG_DIR/.p10k_config.zsh
