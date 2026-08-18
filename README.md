# Dotfiles

macOS setup for Ghostty + tmux + Neovim (LazyVim) + Zsh.

## Quick start (new laptop)

```sh
git clone --recurse-submodules https://github.com/larry-lime/dotfiles ~/.dotfiles && ~/.dotfiles/install.sh
```

That's it. Open a new terminal when it finishes — zsh, tmux, and nvim work out of the gate.

`--recurse-submodules` matters (`nvim/`, `tmux/`, and `zsh/` are git submodules), but the installer re-initializes them if you forget.

If Xcode Command Line Tools aren't installed yet, the script launches Apple's installer and exits — re-run `~/.dotfiles/install.sh` once that finishes. Everything is idempotent; re-running is always safe.

### What `install.sh` does

1. **Xcode CLT + Homebrew** — verifies CLT, installs Homebrew if missing.
2. **Packages** — `tmux neovim fzf ripgrep fd eza sd sesh zoxide lazygit lazydocker gh node fnm`, plus casks `ghostty` and `font-jetbrains-mono-nerd-font` (skip casks with `--no-casks`).
3. **Submodules** — `git submodule update --init --recursive`.
4. **Symlinks** — everything in the layout table below, including `~/.config/ghostty` (Ghostty auto-loads it on launch; reload a running Ghostty with `cmd+shift+,`). Pre-existing real files are moved to `~/.dotfiles-backup-<timestamp>`, never deleted.
5. **Zsh plugins** — pre-clones `zsh-syntax-highlighting` and `zsh-autosuggestions` into `zsh/plugins/` so the first shell is fully working (prompt, zoxide, fzf keybinds included).
6. **tmux plugins** — clones tpm to `~/.config/tmux/.tmux/plugins/tpm` (the path `tmux-plugins.conf` actually loads) and installs all plugins headlessly.
7. **Neovim plugins** — headless `Lazy! sync` so nvim is ready on first launch. LSPs/formatters install via Mason on first use of each filetype.
8. **Option → Ctrl remap** — installs a LaunchAgent (`com.larry-lime.remap-keys`) that runs `scripts/on-login.sh` at every login, remapping **right option → right control** via `hidutil` (which doesn't persist across reboots on its own). Skip with `--no-remap`; applied immediately too.
9. **Henry worktrees** — runs `scripts/setup-henry-worktrees.sh` to lay out the work repo at `~/HenryLabs/henry` (skip with `--no-henry`; requires GitHub auth for the private repo — `gh auth login` first, or re-run the script later).
10. **Verify** — checks every binary and symlink, that zsh (incl. the prompt) and tmux configs load cleanly, that the tmux prefix is `C-f` (what the Ghostty keybinds send), validates the Ghostty config with `ghostty +validate-config`, and confirms the henry worktrees; reports a pass/fail summary.

## Keybind chain (Ghostty → tmux)

`ghostty/config` translates `cmd+*` shortcuts into tmux prefix sequences: every `keybind = ... =text:\x06X` sends **Ctrl-F** (`\x06`, the tmux prefix) followed by `X`. So the whole chain depends on:

- tmux prefix staying `C-f` (`tmux/tmux-keybinds.conf`)
- the target tmux bindings existing: `F`/`T` (tnav), `W` (wt popup), `G` (lazygit), `D` (lazydocker), `|`/`-` (splits), `c`, `&`, `x`, plus tmux defaults `l`, `p`, `n`, `z`, digits
- `tnav`, `wt`, `switch_theme` being reachable in `~/.local/bin`
- `lazygit` and `lazydocker` being installed

The installer verifies the prefix and installs all of the above. The **right option → right control** remap makes ctrl chords (e.g. the prefix itself) reachable from the home row.

## Henry work repo

`scripts/setup-henry-worktrees.sh` (also run by `install.sh`) sets up:

```
~/HenryLabs/henry/
  dev/       main worktree, tracks origin/dev
  main/      tracks origin/main
  staging/   tracks origin/staging
  alpha/ … zeta/   scratch worktrees, local branches off origin/dev
```

It's idempotent: an existing plain clone at `~/HenryLabs/henry` is converted in place (only if fully clean — it aborts rather than lose anything), existing worktrees are left alone. `wt` (`cmd+t` in Ghostty) switches between them as tmux sessions from anywhere in the tree.

## Font

Ghostty is configured to use **ComicCodeLigatures Nerd Font** (`ghostty/config`). It's a custom Nerd Font patch of the paid Comic Code typeface — drop the `.ttf` files into `~/Library/Fonts` manually. Until then Ghostty falls back to a default font; the installer also installs JetBrainsMono Nerd Font as a usable alternative (edit `ghostty/config` to switch).

## Layout reference

| Source in repo | Symlinked to        | Notes                                    |
| -------------- | ------------------- | ---------------------------------------- |
| `.zshenv`      | `~/.zshenv`         | sets `ZDOTDIR=~/.config/zsh`             |
| `.tmux.conf`   | `~/.tmux.conf`      | sources `~/.config/tmux/`                |
| `.fzf.zsh`     | `~/.fzf.zsh`        | fzf shell integration                    |
| `nvim/`        | `~/.config/nvim`    | submodule (LazyVim fork)                 |
| `tmux/`        | `~/.config/tmux`    | submodule; tpm lives at `.tmux/plugins/` |
| `zsh/`         | `~/.config/zsh`     | submodule; plugins clone into `plugins/` |
| `ghostty/`     | `~/.config/ghostty` | flat config                              |
| `.local/bin/`  | `~/.local/bin`      | personal scripts (`tnav`, `wt`, `switch_theme`, ...) |
| `scripts/`     | (not symlinked)     | `on-login.sh` runs via LaunchAgent       |

## Key remap

`scripts/on-login.sh` remaps **right option → right control** with `hidutil` so tmux/nvim ctrl chords are reachable. Because `hidutil` mappings reset on reboot, `install.sh` registers it as a LaunchAgent:

```sh
# check it's loaded
launchctl list | grep com.larry-lime.remap-keys
# remove it
launchctl unload ~/Library/LaunchAgents/com.larry-lime.remap-keys.plist \
  && rm ~/Library/LaunchAgents/com.larry-lime.remap-keys.plist
```

## Optional / machine-specific

These are referenced by the zsh config but guarded, so they're optional:

- **Rust** — `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh` (`~/.cargo/env` is sourced only if present)
- **`~/.gemini-api-key`** — sourced if present
- **Java / Android / colima** — `JAVA_HOME`, `ANDROID_HOME`, `DOCKER_HOST` are exported in `zsh/macos_config.zsh`; harmless if the tools aren't installed

## Troubleshooting

- **Stock prompt / aliases missing in an open terminal** — that shell predates the symlinks; run `exec zsh` or open a new terminal.
- **tmux plugins missing** — inside tmux press `prefix + I`, or re-run `install.sh`.
- **nvim plugin errors on first open** — run `:Lazy sync`, then `:Mason` for LSPs.
- **`z` not jumping** — zoxide initializes in `zsh/zoxide.zsh`; check `command -v zoxide`.
- **cmd shortcuts dead in Ghostty** — reload config (`cmd+shift+,`) and confirm you're inside tmux; the keybinds send tmux prefix sequences.
- **option key stopped acting as ctrl after reboot** — `launchctl load ~/Library/LaunchAgents/com.larry-lime.remap-keys.plist` (or re-run `install.sh`).
- **Anything else** — re-run `~/.dotfiles/install.sh` and read the verify summary at the end.
