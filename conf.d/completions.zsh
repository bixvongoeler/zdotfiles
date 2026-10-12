# --- Completions Config --- #
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# NOTE: list-colors is set from LS_COLORS in lib/zinit.zsh (atload of trapd00r/LS_COLORS).
zstyle ':completion:*' menu no
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:*' fzf-flags '--height=50%' '--scrollbar=▐' '--prompt=   ' '--preview-window=right:50%:border-sharp' '--color=scrollbar:#E7005F'
# Left arrow toggles multi-select (added on top of fzf-tab's default ctrl-space:toggle).
zstyle ':fzf-tab:*' fzf-bindings 'left:toggle+down'
# Preview pane (runs in fzf-tab's preview subshell):
#   dir         -> eza listing
#   text file   -> bat (first 200 lines)
#   binary/empty-> icon + name, then a dim [binary file] / [empty file] marker
# `grep -qI .` succeeds only if the file has a line and no NUL bytes in its
# first block, i.e. it looks like text. cd to the parent so eza prints just
# the name, not the full path.
# Non-file candidates (e.g. `rm -<Tab>` options) have no $realpath: show nothing.
_ftb_eza_preview='if [[ ! -e $realpath ]]; then
    :
elif [[ -d $realpath ]]; then
    eza -1 -A -I ".git|.claude|.vscode|.zed|.github" --color=always --icons=always $realpath
elif [[ -s $realpath ]] && grep -qI . -- $realpath 2>/dev/null; then
    bat --color=always --style=numbers --paging=never --line-range=:200 \
        --terminal-width=${FZF_PREVIEW_COLUMNS:-80} -- $realpath
else
    cd ${realpath:h} && eza -1 -d --color=always --icons=always -- ${realpath:t}
    [[ -s $realpath ]] && print "\n\e[2m[binary file]\e[0m" || print "\n\e[2m[empty file]\e[0m"
fi'
zstyle ':fzf-tab:complete:cd:*' fzf-preview $_ftb_eza_preview
zstyle ':fzf-tab:complete:(ls|lsd|eza):*' fzf-preview $_ftb_eza_preview
# Editors and file-manipulation commands get the same preview.
zstyle ':fzf-tab:complete:(zed|zed-preview|zedit|rm|cp|mv|ln|cat|bat|less|open|touch|mkdir|rmdir|chmod|trash):*' \
    fzf-preview $_ftb_eza_preview
