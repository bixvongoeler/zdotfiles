# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Bix's personal zsh configuration, living at `~/.config/zsh` (which is `$ZDOTDIR`). It is loosely inspired by [mattmc3/zdotdir](https://github.com/mattmc3/zdotdir) — cloned for reference into `.docs/reference-zdotdir/` — but is deliberately not a copy; patterns were borrowed piecemeal. Plugins are managed with **zinit** (its wiki is cloned into `.docs/zinit-wiki/`).

**Framing for agents — read this first.** Nothing documented here is the *correct* or mandated way to do things — not the current setup, and not the reference repos it borrowed from. This file describes the **current state** of the configuration so you can work in it accurately. The user is actively iterating on this setup and wants help questioning and improving it: when you see a better approach, say so rather than treating the existing pattern as a constraint.

## Keeping these docs current

Whenever the configuration changes — whether **you** make the change, or you **notice the user changed something** on their own — promptly update this CLAUDE.md and the affected per-directory CLAUDE.md files so they always reflect reality. This includes:

- files added / removed / renamed in `conf.d/`, `functions/`, `lib/`, or `completions/`
- plugins added, removed, or re-iced in `lib/zinit.zsh`
- changed conventions (naming, prefixes, load order, where a kind of config lives)
- resolved or newly discovered quirks and open items

These docs are a snapshot, not a spec; a stale snapshot is worse than none.

## Shell startup flow

1. **`~/.zshenv`** — a symlink to `.zshenv` in this repo (the repo file is the real one). Runs for *all* shells. Sole job: set XDG base dirs and `ZDOTDIR=~/.config/zsh` so everything else lives here. On a new machine: `ln -s ~/.config/zsh/.zshenv ~/.zshenv`.
2. **`.zprofile`** — login shells only. Sources `.zsecret` (gitignored secrets) and sets `skip_global_compinit=1` (Ubuntu). Intended for machine-specific login config. Anything needed by *every* interactive shell must not live here (see the pyenv note in `conf.d/pyenv.zsh`).
3. **`.zshrc`** — interactive shells, in order:
   - opt-in `zprof` profiling (`zprofrc` alias = `ZPROFRC=1 zsh`)
   - Powerlevel10k **instant prompt** (must stay near the top; nothing before it may write to the console)
   - defines `ZSH_CONFIG_DIR` / `ZSH_DATA_DIR` / `ZSH_CACHE_DIR`, exports `TMPDIR`
   - `setopt EXTENDED_GLOB INTERACTIVE_COMMENTS`
   - prepends `completions/` to `fpath`
   - lazy-autoloads every file in `functions/` (`_*`-prefixed files and `*.md` docs excluded)
   - sources `lib/zinit.zsh` — zinit bootstrap and *all* plugin declarations
   - sources every `conf.d/*.zsh` in glob (alphabetical) order; `__init__.zsh` sorts first; `~`-prefixed files are skipped
   - sources `.zshrc.local` if present (machine-local overrides, gitignored)
   - sources `.p10k_config.zsh` (prompt configuration)

## Directory guide

- `conf.d/` — interactive-shell config, one concern per file (aliases, history, keybinds, per-tool setup). See @conf.d/CLAUDE.md
- `lib/` — explicitly-sourced library code: zinit bootstrap + plugin declarations, and helpers they need. See @lib/CLAUDE.md
- `functions/` — lazy-autoloaded shell functions, one file per function. See @functions/CLAUDE.md
- `completions/` — custom completion definitions, prepended to `fpath` by `.zshrc`. Files are named `_<command>` with a `#compdef` first line (currently just `_zed` for `zed.exe`).
- `.docs/` — reference material, not shell config: `reference-zdotdir/` and `zinit-wiki/` (gitignored clones), `zsh-tips/` (personal zsh notes/cheatsheets), `tools.md` (CLI tools to maybe adopt).

## Conventions currently in use

- **`~` filename prefix disables a file**: the `.zshrc` conf.d loop skips `~*` names, and `.gitignore` excludes them — rename to disable without deleting.
- **`_` filename prefix means "not an autoloaded function"**: `functions/_*` are excluded from autoload (they stay on `fpath`, which is what completion files want); `lib/_*.zsh` are helper files sourced explicitly.
- **Machine-local, gitignored escape hatches**: `.zsecret` (secrets, sourced by `.zprofile`) and `.zshrc.local` (sourced last by `.zshrc`).
- **XDG-first**: state and caches are pushed out of `$HOME` (zinit under `$XDG_DATA_HOME`, `LESSHISTFILE` under `$XDG_STATE_HOME`, `TMPDIR` under `$XDG_CACHE_HOME`, …). Exception: history lives at `$ZDOTDIR/.zsh_history` (gitignored).

## Commands

- **Smoke test after edits**: `zsh -ic exit` — confirms an interactive shell starts without errors. Expect harmless noise when run without a real TTY (`can't change option: monitor`, `can't change option: zle`, a gitstatus init failure); real problems are syntax errors, `command not found`, or p10k instant-prompt warnings.
- **Startup performance**: `zprofrc` (from inside a shell) launches a profiled shell and prints `zprof` output.
- **Reload**: `exec zsh`.
- **Plugins**: `zinit update --all` (or `zinit update <plugin>`); `zinit delete --all --yes && exec zsh` for a full reinstall. Stale completions: delete `.zcompdump*` and restart.
- Final verification is always the user opening a real terminal — a passing smoke test is necessary, not sufficient.

## Platform

Currently running on **WSL2 Ubuntu** (hence `batcat`, `explorer.exe`, Windows Terminal handling, `zed.exe` completions). Some macOS fragments remain from earlier use (iTerm2 integration, hardcoded `/opt/homebrew` paths, commented brew shellenv). **Stated future goal:** make the config properly cross-platform and machine-agnostic — platform guards plus automated install/setup. Today's WSL specifics are pragmatically hacked in; when touching platform-specific code, prefer moves that bring it closer to that goal rather than deepening the WSL coupling.

## Known quirks / open items

- `.p10k_config.zsh` is sourced twice: at the end of `.zshrc` and again at the end of `lib/zinit.zsh`.
- `HISTDUP=erase` in `conf.d/history.zsh` is not a real zsh parameter (likely carried in from a tutorial; the `setopt hist_*` lines do the actual work).
- `conf.d/cmdk.zsh` is a fully commented-out placeholder (references a `lib/cmdk/` that isn't present); `conf.d/fix_colors.zsh` is empty.
- `functions/zedit` hardcodes a macOS homebrew path.
- The repo's `.zshenv` is not yet tracked by git (it's the real bootstrapper file as of 2026-07-16, after flipping the old `repo → ~/.zshenv` symlink direction).
