# Setup summary & cheatsheet

Snapshot of the 2026-07 tooling overhaul. Configs live in this repo and
deploy by `cp` to their live locations (see per-file comments).

## What changed

### Neovim (both machines unless noted)
- `init.vim` → `init.lua`; cluster mirror in `gruffalo.lua` (OSC52
  clipboard, no copilot/claudecode/typst, LSPs guarded by executable
  checks, plugins + treesitter parsers on the apps array).
- Removed: ALE, NERDTree (+devicons/syntax), vim-gitgutter, dead coc
  remnants, dead cmp sources (cmp-copilot, cmp_git).
- Added: gitsigns, which-key, harpoon (trial), treesitter-textobjects,
  undotree, indent-blankline, neogit + diffview, vim-tpipeline.
- Copilot (mac): copilot.lua + copilot-cmp — completions in the cmp menu,
  ghost text off; pack-installed copilot.vim retired.
- LSP: `root_markers` + plain `vim.lsp.enable`; R buffers 2-space indent
  (lintr/styler/editor agree); `<leader>fm` formats via LSP (styler for
  R, typstyle for typst), buffer-local snakefmt override for Snakefiles;
  Trouble mappings; inline diagnostics enabled.
- Forked with local patches: `perugolate/copilot-cmp` (deprecated
  is_stopped call), `perugolate/undotree` (E1312 on quit).
- QoL: undofile, ignorecase/smartcase.

### Shell (mac zsh)
- television owns `Ctrl-T` (fzf keybindings retired; fzf binary kept as
  zoxide's `zi` engine); catppuccin theme; custom zoxide cable channel.
- atuin keeps `Ctrl-R`; sync restored after updating the cluster to
  18.17.1 (musl binary on the apps array) — the old client spoke the
  deprecated sync-v1 protocol. `atuin status` 404 is cosmetic (atuin#3140).
- zoxide on both machines (`--bin-dir` to apps array on gruffalo).
- Completions: `~/.zsh/completions` + brew site-functions on fpath
  *before* oh-my-zsh's compinit; `_atuin`/`_docker` generated; regenerate
  after major version bumps.
- Secrets in untracked `~/.zshrc.secrets` (sourced if present).

### tmux + ghostty
- `.config/tmux/tmux.conf`: prefix `C-a`, vi copy-mode, OSC52
  passthrough (`set-clipboard on`), true color, `escape-time 10`,
  tpipeline status line (nvim's lualine projected into the tmux bar).
- Ghostty auto-starts tmux: every tab runs `bin/tmux-ghostty-tab` —
  first tab is the persistent `main` session, extra tabs get independent
  throwaway sessions. `Ctrl-D`/`exit` closes shell and tab; `Cmd-W` kills
  the tab's session. Only `main` survives closing (reattached by the
  next first tab). tmux forwards `session · pane-title` as the tab title
  (`main · user@host`, updating on ssh), and the status bar's right end
  shows the session name — so tabs are distinguishable at a glance.
- Ghostty `Alt+V` vim-style scrollback key table (useful outside tmux
  only — inside tmux, scrollback belongs to tmux copy-mode).
- Cluster: same conf; `tmux new -A -s main` after ssh; sessions survive
  dropped connections (login-node reboots and SLURM job ends still kill
  them).

## Cheatsheet

### Neovim
| Keys | Action |
|---|---|
| `<leader>fm` / `gq{motion}` | format buffer/selection (styler / snakefmt / typstyle) |
| `<leader>xx` / `<leader>xX` | Trouble diagnostics (all / current buffer) |
| `ca` (=`gra`), `grn`, `grr`, `gri`, `K` | code action, rename, references, implementation, hover |
| `<leader>ff/fg/fb/fh`, `C-p` | telescope: files, live grep, buffers, help |
| `<leader>ha` / `<leader>hh` / `<leader>1-4` | harpoon: pin file, menu, jump to slot |
| `<leader>gg` | Neogit status (`s` stage, `cc` commit, `?` help, `q` quit) |
| `<leader>gd/gh/gH/gq` | diffview: working tree, file history, repo history, close |
| `<leader>u` | undotree (persistent undo incl. branches) |
| `daf`/`yif` etc. | a function / inner function textobject |
| `daa`/`cia` etc. | an argument / inner argument (comma-aware) |
| `]f` / `[f` | next / previous function (jumplist-aware, `C-o` back) |
| `-` | oil: parent directory as editable buffer |
| `gcc` / `ys cs ds` | comment / surround |
| `<Space>` + pause | which-key menu |
| `,` / `<leader>cd` | neoterm: send line/selection / send Rmd chunk |

### Shell
| Keys | Action |
|---|---|
| `Ctrl-T` | television, context-aware: `z `→ frecent dirs, `cd `/`ls `→ dirs, `git checkout `→ branches, fallback files |
| `Ctrl-R` | atuin history (synced mac ↔ gruffalo) |
| `z <fragment>` | zoxide frecency jump (no picker) |
| `Ctrl-G` | zsh-vi-mode escape → normal mode (`v`/`V` visual, `y`/`d` operate) |
| `vv` (normal mode) | edit current command line in nvim |
| `Ctrl-A Ctrl-A` | beginning of line (literal C-a through tmux; works on both machines) |
| `Ctrl-V Ctrl-J` | insert literal newline (multiline prompt editing) |
| `Ctrl-Y` | paste system clipboard |

### tmux (prefix `C-a`)
| Keys | Action |
|---|---|
| `C-a [` or `C-a v` | copy mode: `hjkl`/`w`/`gg`/`G`/`/`search; `v`/`V`/`C-v` select; `y` yank → clipboard (OSC52, works from gruffalo) |
| `C-a ]` | paste tmux buffer (works cluster-side; the reliable paste) |
| `C-a c` / `C-a n` / `C-a 1-9` | new / next / jump to window |
| `C-a \|` / `C-a -` | split right / below (inherits cwd) |
| `C-a d` | detach (session persists) |
| `C-a s` | session tree (the built-in "sesh") |
| `C-a C-a <key>` | send prefix to inner tmux (nested gruffalo session) |
| `tmux new -A -s main` | attach-or-create; the post-ssh habit on gruffalo |

Ghostty tabs = independent tmux sessions: first tab = persistent `main`;
extra tabs are ephemeral (`Ctrl-D`/`exit`/`Cmd-W` all end them for real).
Windows created inside a tab (`C-a c`) belong to that tab's session.

### Ghostty (outside tmux only)
`Alt+V` scroll table: `j/k` lines, `C-d/C-u` half-page, `gg`/`G`
top/bottom, `Shift+hjkl` adjust selection, `y` copy, `Esc`/`q` exit.
`Cmd+Shift+,` reloads config.
