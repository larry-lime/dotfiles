---
name: setup-new-laptop
description: Bootstrap this dotfiles repo on a fresh macOS machine so zsh, tmux, and nvim (plus the option→ctrl key remap) fully work. Use when the user says "set up this laptop", "bootstrap my dotfiles", "new machine setup", or the environment looks unconfigured (missing symlinks, missing brew packages).
---

# Set up a new laptop

Everything is driven by one idempotent script: `~/.dotfiles/install.sh`. Prefer running it over doing steps by hand — it backs up pre-existing files, is safe to re-run, and prints a verify summary at the end.

## Steps

1. **Ensure the repo is at `~/.dotfiles`** with submodules:
   ```sh
   git clone --recurse-submodules https://github.com/larry-lime/dotfiles ~/.dotfiles
   ```
   If already cloned without submodules, the installer fixes that itself.

2. **Run the installer** (expect several minutes for brew packages and the headless nvim plugin sync):
   ```sh
   ~/.dotfiles/install.sh
   ```
   Flags: `--no-casks` (skip Ghostty + fonts), `--no-remap` (skip the option→ctrl LaunchAgent), `--no-henry` (skip the ~/HenryLabs/henry worktree setup).

3. **If it exits asking for Xcode CLT**: Apple's GUI installer was launched. The user must click through it; re-run `install.sh` afterward.

4. **Read the verify summary** at the end of the script output. Every line should be `✓`. If any are `!`, fix those specifically (see the troubleshoot-dotfiles skill) and re-run the script to confirm.

## What "fully working" means (acceptance checklist)

- `zsh -i -c exit` produces no errors (plugins, zoxide, fzf, prompt all load)
- `tmux new-session -d` starts cleanly and `prefix + I` isn't needed (plugins already in `~/.config/tmux/.tmux/plugins/`)
- `nvim --headless +q` exits cleanly; plugins already synced by the installer
- `~/.local/bin` is on PATH and scripts like `tnav`, `wt`, `switch_theme` resolve
- `launchctl list | grep com.larry-lime.remap-keys` shows the key-remap agent (right option → right control via hidutil, re-applied at every login)
- Ghostty config validates: `/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config`
- Keybind chain intact: tmux prefix is `C-f` (`tmux show-option -g prefix`) — Ghostty's cmd shortcuts all send `\x06` (Ctrl-F) sequences — and `lazygit`/`lazydocker` are installed for the `G`/`D` popups
- `~/HenryLabs/henry/` contains worktrees `dev` (main worktree), `main`, `staging`, `alpha`–`zeta` (`git -C ~/HenryLabs/henry/dev worktree list`); requires GitHub auth — if it was skipped, run `gh auth login` then `~/.dotfiles/scripts/setup-henry-worktrees.sh`

## Gotchas

- tpm's real path is `~/.config/tmux/.tmux/plugins/tpm` (note the extra `.tmux/`) — that's what `tmux/tmux-plugins.conf` loads. Don't clone it to `~/.config/tmux/plugins/tpm`.
- The Ghostty font (ComicCodeLigatures Nerd Font) is paid and manual: `.ttf` files go in `~/Library/Fonts`. JetBrainsMono Nerd Font is installed as a fallback.
- Rust and `~/.gemini-api-key` are optional; the zsh config guards them.
- Mason LSPs install lazily on first use of each filetype — no action needed.
