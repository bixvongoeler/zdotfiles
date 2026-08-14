# --- Completions Config --- #
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# NOTE: unquoted on purpose. fzf-tab reads this style with `zstyle -a` and does
# NOT evaluate it, so it must already be the expanded color array. The lazy
# '${(s.:.)LS_COLORS}' form colors zsh's native menu but leaves fzf-tab's list
# blank. LS_COLORS is populated by the trapd00r plugin before this file loads.
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:(ls|lsd|eza):*' fzf-preview 'eza -1 -A -I ".git|.claude|.vscode|.zed|.github" --color=always --icons=always $realpath'
