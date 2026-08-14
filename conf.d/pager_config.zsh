# Pager behavior
export LESS='-R -F -i -M -J -W --mouse --incsearch'
#  -R           pass ANSI color through (git, grep --color, diff, etc.)
#  -F           quit immediately if content fits on one screen
#  -i           smart-case search: case-insensitive unless the query has uppercase
#  -M           verbose prompt — filename, line numbers, % position
#  -J           status column in the left margin marking lines with search matches
#  -W           briefly highlight the first new line after any multi-line jump
#  --mouse      wheel scrolling            (needs less 530+)
#  --incsearch  editor-style incremental search (needs less 530+)

# Keep $HOME clean — less otherwise drops ~/.lesshst
export LESSHISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/less/history"
mkdir -p "$(dirname "$LESSHISTFILE")"
