# --- fzf-tab icons --- #
# fzf-tab has no icon option, so wrap its internal -ftb-colorize and prepend
# the same icon eza shows in the preview pane. The icon goes into `dpre`
# (display prefix): it is not fuzzy-matched and not inserted on accept.
#
# eza runs once per directory (cached until the dir's mtime changes), not once
# per candidate. If eza or the fzf-tab internal is missing, this file is a
# no-op and fzf-tab behaves exactly as stock.

command -v eza >/dev/null || return
[[ -r $FZF_TAB_HOME/lib/-ftb-colorize ]] || return

# Build the original from fzf-tab's file directly: under zinit, fzf-tab's lib/
# isn't on fpath, so `autoload +X` + `functions -c` would copy an unloaded stub.
functions[-ftb-colorize-orig]=$(<$FZF_TAB_HOME/lib/-ftb-colorize)

typeset -gA _ftb_icon_map
typeset -g _ftb_icon_dir _ftb_icon_mtime

# Fill _ftb_icon_map (name -> glyph) for $1 from a single eza call.
-ftb-icon-load() {
    emulate -L zsh
    local dir=$1 line
    local -a st
    zstat -A st +mtime -- $dir 2>/dev/null
    [[ $dir == $_ftb_icon_dir && $st[1] == $_ftb_icon_mtime ]] && return
    _ftb_icon_dir=$dir
    _ftb_icon_mtime=$st[1]
    _ftb_icon_map=()
    # Each line is "<glyph> <name>"; glyph is one character.
    for line in "${(@f)$(EZA_ICON_SPACING=1 command eza -1 -a --icons=always \
            --color=never --no-quotes -- $dir 2>/dev/null)}"; do
        _ftb_icon_map[${line[3,-1]}]=${line[1]}
    done
}

-ftb-colorize() {
    -ftb-colorize-orig "$@"
    -ftb-icon-load ${1:h}
    local icon=$_ftb_icon_map[${1:t}]
    [[ -n $icon ]] && dpre+="$icon "
}
