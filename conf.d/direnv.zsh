# --- direnv --- #
# Hook direnv where it's installed, unless the system already did: NixOS's
# /etc/zshrc adds the same hook before this file runs.
if (( $+commands[direnv] )) && [[ ${precmd_functions[(r)_direnv_hook]} != _direnv_hook ]]; then
    eval "$(direnv hook zsh)"
fi
