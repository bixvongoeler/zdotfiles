# conf.d/ — CLAUDE.md

Referenced from the root CLAUDE.md. Describes the *current* contents of `conf.d/`; not a spec. **Update this file whenever a conf.d file is added, removed, renamed, disabled, or changes responsibility** — the per-file sections below are intentionally modular so entries can come and go.

## How this directory works

- Every `*.zsh` file here is sourced by `.zshrc` for interactive shells, in glob (alphabetical) order, **after** plugins are declared (`lib/zinit.zsh`) — though turbo-mode plugins actually finish loading after the first prompt, i.e. after all of conf.d has run.
- `__init__.zsh` is named to sort first; put anything other conf.d files depend on there.
- Prefix a filename with `~` to disable it without deleting (skipped by the loop, gitignored).
- Convention: one concern per file — an alias set, a tool's init, a subsystem's config.

## Per-file responsibilities

### `__init__.zsh`
Runs before all other conf.d files. Sets default apps (`EDITOR`/`VISUAL` = `zed --wait`, `PAGER=less`, `MANPAGER` via `batcat`), dedupes `path` (`typeset -U`), sets `cdpath` (includes `$XDG_PROJECTS_DIR` = `~/dev`), and prepends `~/.local/bin` and `~/.cargo/bin` to `path`.

### `aliases.zsh`
`lsd`-based listing aliases (`l`, `ls`, `la`, `lla`, `lt`, `ltd`, `lsl`, `lss`), `vim`→`nvim`, `c`=clear, `gs`=`git status`. Also defines `eopen()`, a WSL helper that converts a path to `\\wsl.localhost\Ubuntu\...` form and opens it in Windows Explorer.

### `bindkey.zsh`
Keybindings: `^P`/`^N` history search, ctrl+←/→ word movement, alt+←/→ beginning/end of line, ctrl+backspace kill word.

### `cmdk.zsh`
Placeholder, fully commented out. Would source a `cmdk` function from `$ZDOTDIR/lib/cmdk/cmdk.sh`, which doesn't currently exist (`cmdk` is gitignored).

### `completions.zsh`
Completion-system `zstyle`s plus fzf-tab styles: case-insensitive matching, `menu no` (fzf-tab replaces the menu), descriptions format, no sorting for `git checkout`, and `eza`-based directory previews for `cd`/ls-family completions. **Load-order note (documented in the file):** `list-colors` is set with the *pre-expanded* `${(s.:.)LS_COLORS}` array on purpose — fzf-tab reads it without evaluating, and `LS_COLORS` must already be populated by the trapd00r plugin, which `lib/zinit.zsh` loads immediately (not turbo) before conf.d runs.

### `export_vars.zsh`
Misc environment variables; currently just `CLAUDE_CONFIG_DIR`.

### `fix_colors.zsh`
Currently empty (untracked placeholder).

### `fzf.zsh`
`fzf --zsh` shell integration (keybindings + completion); `FZF_DEFAULT_COMMAND` uses `fd -HI` with colors, `--ansi` in default opts, same command for ctrl-T.

### `history.zsh`
History config: `HISTFILE=$ZDOTDIR/.zsh_history`, 25k entries, `sharehistory`, `appendhistory`, and the `hist_ignore*_dups`/`hist_save_no_dups` options. (`HISTDUP=erase` is also set but is not a real zsh parameter — see root CLAUDE.md quirks.)

### `pager_config.zsh`
`LESS` flags (each documented inline in the file: colors, quit-if-one-screen, smart-case, verbose prompt, mouse, incsearch) and `LESSHISTFILE` moved under `$XDG_STATE_HOME`.

### `pyenv.zsh`
pyenv + pyenv-virtualenv init for every interactive shell. Lives here (not `.zprofile`) so non-login shells get pyenv too — rationale documented in the file header. Guards on `$+commands[pyenv]`.

### `terminal.zsh`
Terminal-specific integration switched on `$TERM_PROGRAM`: ghostty, iTerm2 (macOS leftover), and vscode (with a HISTFILE preserve/restore workaround). Separately, when `$WT_SESSION` is set (Windows Terminal), adds precmd/preexec hooks that set the tab title to the cwd / running command. Exports `COLORTERM=truecolor`.

### `zoxide.zsh`
zoxide (`cd` replacement) init, guarded on the command existing; `_ZO_ECHO=1` prints the resolved directory on jump.
