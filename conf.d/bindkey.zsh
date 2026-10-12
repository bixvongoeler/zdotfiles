# --- Keybindings --- #
# Emacs keymap, explicitly: zsh starts in vi mode when $EDITOR or $VISUAL
# contains "vi" (zed-preview does), and child shells inherit them.
bindkey -e

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# iTerm2 (natural text editing) and Zed's terminal send ⌥←/⌥→ as \eb/\ef
# and ⌘←/⌘→ as ^A/^E; the CSI forms come from terminals without that mapping.
bindkey '\eb' backward-word         # ⌥←
bindkey '\ef' forward-word          # ⌥→
bindkey '^A' beginning-of-line      # ⌘←
bindkey '^E' end-of-line            # ⌘→
bindkey '^[[1;3D' backward-word     # ⌥← (CSI)
bindkey '^[[1;3C' forward-word      # ⌥→ (CSI)
bindkey '^[[1;5D' backward-word     # ctrl+←
bindkey '^[[1;5C' forward-word      # ctrl+→
bindkey '^H' backward-kill-word     # ctrl+⌫
