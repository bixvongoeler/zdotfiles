# lib/ — CLAUDE.md

Referenced from the root CLAUDE.md. Describes the *current* contents of `lib/`; not a spec. **Update this file whenever plugins are added/removed/re-iced or lib files change.**

## How this directory works

Files here are **explicitly sourced** (nothing auto-discovers this directory). `.zshrc` sources `lib/zinit.zsh`, which in turn sources `lib/_fix-omz-plugin.zsh`. The `_` prefix marks a helper file, matching the repo-wide "underscore = not autoloaded" convention.

## `zinit.zsh` — plugin manager bootstrap + all plugin declarations

Single home for everything zinit. Structure:

1. **Bootstrap**: clones zinit to `$XDG_DATA_HOME/zinit/zinit.git` if missing, then sources it.
2. **Sources `_fix-omz-plugin.zsh`** so the fix function exists before any `OMZP::` plugin installs.
3. **Immediate (non-turbo) loads** — needed before the first prompt:
   - `romkatv/powerlevel10k` (`depth=1`) — the prompt; must load immediately for instant-prompt to work.
   - `trapd00r/LS_COLORS` — `atclone` generates `clrs.zsh` via `dircolors`, `atpull'%atclone'` regenerates on update, `pick` sources it, `atload` feeds it to completion `list-colors`. Loads immediately because `conf.d/completions.zsh` needs `$LS_COLORS` populated.
4. **Turbo block** (`zinit wait lucid for …` — loads after the first prompt is drawn):
   - `fast-syntax-highlighting`, with `atinit` running `zicompinit; zicdreplay` — **this is where compinit happens** (with `-C`, skipping the security check), plus `compdef _batcat bat`.
   - `OMZP::colored-man-pages`, with `atclone"_fix-omz-plugin"`.
   - `zsh-users/zsh-completions` with `blockf` (zinit manages fpath, not the plugin).
   - `zsh-users/zsh-autosuggestions` with `atload"!_zsh_autosuggest_start"`.
5. **Separately iced turbo plugins**: `Aloxaf/fzf-tab` (`wait lucid`), `zdharma-continuum/history-search-multi-word` (`wait lucid`, uses `load` rather than `light`, with a `reset-prompt-protect` zstyle).
6. Sources `.p10k_config.zsh` at the end (note: `.zshrc` also sources it — known duplication, see root CLAUDE.md).

### zinit quick reference (as used here)

- `wait` + `lucid` = turbo mode: load after first prompt, silently. Biggest startup-speed lever.
- `light` = no tracking/reporting (faster); `load` = tracked, can be reported/unloaded.
- `blockf` = block the plugin from editing `fpath` itself.
- `atclone`/`atpull'%atclone'` = run at install / re-run on update; `atinit`/`atload` = run before / after load.
- `zicompinit; zicdreplay` = run compinit once inside the turbo timeline, then replay `compdef` calls queued by turbo-loaded plugins. Full docs: `.docs/zinit-wiki/`.

## `_fix-omz-plugin.zsh` — OMZ snippet workaround

Defines `_fix-omz-plugin`, invoked via `atclone` on `OMZP::` plugins: a workaround for zinit issue #504 that sparse-clones the ohmyzsh repo and copies a plugin's auxiliary files into the snippet dir, removing zinit's subversion dependency. **Side effect to be aware of:** the file sets `setopt RE_MATCH_PCRE` globally at source time (the function's regex needs it).
