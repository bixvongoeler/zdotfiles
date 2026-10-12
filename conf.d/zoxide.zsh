# --- zoxide ---
# setup zoxide cd replacement (z, zi)

if (( $+commands[zoxide] )); then
    # configure zoxide through env vars
    export _ZO_ECHO='1'

    # initialize zoxide
    eval "$(zoxide init zsh)"
fi
