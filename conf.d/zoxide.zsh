# --- zoxide ---
# setup zoxide cd replacement

installed_zoxide=$(command -v zoxide)

if [[ -n "$installed_zoxide" ]]; then
    # configure zoxide through env vars
    export _ZO_ECHO='1'

    # initialize zoxide
    eval "$(zoxide init zsh)"
fi
