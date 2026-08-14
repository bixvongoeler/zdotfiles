# functions/ — CLAUDE.md

Referenced from the root CLAUDE.md. Describes the *current* contents of `functions/`; not a spec. **Update this file whenever a function is added, removed, or changes behavior** — entries below are modular on purpose.

## How this directory works

- `.zshrc` adds this directory (and any subdirectories) to `fpath` and runs `autoload -Uz` on every file **except `_*`-prefixed ones and `*.md` docs** (glob `*~*/_*~*.md`). Each file becomes a lazy-loaded function: nothing executes until first call.
- One file per function; filename = function name; no extension; no need to be executable.
- `_*` files are skipped by autoload but stay on `fpath` — the right place for completion functions. Corollary (noted in `gl_run`'s header): a shared *helper function* must **not** get an underscore name, or it silently never autoloads.
- Two authoring styles currently coexist, both of which work with zsh-style autoload:
  - **body-only**: the file's contents *are* the function body (`gld`, `gln`, `gl_run`)
  - **self-defining**: the file contains `name() { … }` (most of the others)

## Current functions

### `color-test-256`
Prints a 256-color terminal reference table with escape-code cheatsheet.

### `fh`
"Find history": fuzzy-search shell history with fzf and place the selection on the command line (`print -z`) rather than executing it.

### `fif`
"Find in files": ripgrep-all (`rga`) search with an fzf preview pane; opens the selected file.

### `gld` / `gln` / `gl_run`
Git log helpers: `gld <days>` = last N days, `gln <count>` = last N commits. Both are thin wrappers over the shared worker `gl_run` (mode as `$1`). Graph + all refs, `refs/archive/*` excluded by default; flags `-F` (full format), `-P` (print command), `-U` (include archived refs), `-S` (`--stat`), `-h` (help).

### `init_conda`
Manually run conda's shell hook on demand — keeps conda's slow init block out of shell startup.

### `invert_pdf`
Color-inverts a PDF via ImageMagick (`magick -density 300 … -negate`), writing `<name>_inverted.pdf`.

### `proton_port`
ProtonVPN port-forwarding keepalive: loops a NAT-PMP request (py-natpmp) against `10.2.0.1` every 45s until it errors.

### `quickgit`
`git add . && commit && push` with the given message, defaulting to `update-YYYYMMDD-HHMM`.

### `zedit`
Opens a file in zed-preview via hardcoded `/opt/homebrew/bin/zed-preview` (macOS leftover; broken on WSL).
