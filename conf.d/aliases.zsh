# --- Aliases --- #
# alias ls='lsd --color always --icon always'
alias l='lsd'
alias ls='lsd'
alias la='lsd -A'
alias lla='lsd -la --ignore-config'
alias lt='lsd --tree --depth 2'
alias ltd='lsd --tree --depth 3 -d'
alias lsl='lsd --blocks=date,size,name'
alias lss='lsd --blocks=name,size | sort'

alias vim='nvim'
alias c='clear'

# alias open='explorer.exe' # for wsl windows

eopen() {
    # 1. Get the absolute path
    local REQ_FULL_PATH=$(realpath "$1")

    # 2. Define the prefix (using single quotes so 4 backslashes are stored as exactly 4 backslashes)
    local WSL_PREFIX='\\wsl.localhost\Ubuntu'

    # 3. Replace all forward slashes with backslashes using Zsh's built-in expansion
    local REQ_FULL_PATH_BACKSLASHED="${REQ_FULL_PATH//\//\\}"
    local FULL_WINDOWS_PATH="${WSL_PREFIX}${REQ_FULL_PATH_BACKSLASHED}"

    # 4. Use print -r to output the raw string without interpreting backslashes
    # print -r -- "${FULL_WINDOWS_PATH}"

    # 5. Open the path in Windows Explorer
    explorer.exe "${FULL_WINDOWS_PATH}"
}
alias gs='git status'
