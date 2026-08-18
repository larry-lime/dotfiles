---
name: troubleshoot-dotfiles
description: Diagnose and fix a broken dotfiles setup — zsh errors on startup, tmux plugins/theme missing, nvim plugin failures, scripts not on PATH, or the option→ctrl remap not working. Use when something in the shell/tmux/nvim environment misbehaves.
---

# Troubleshoot the dotfiles setup

First move for almost any breakage: re-run `~/.dotfiles/install.sh` — it's idempotent and its verify section pinpoints what's wrong. Use the checks below to diagnose a specific symptom.

## Quick diagnosis

```sh
zsh -i -c exit                       # zsh must start silently
ls -la ~/.zshenv ~/.tmux.conf ~/.fzf.zsh ~/.config/{zsh,tmux,nvim,ghostty} ~/.local/bin  # all symlinks into ~/.dotfiles
git -C ~/.dotfiles submodule status  # no '-' prefix (uninitialized) on nvim/tmux/zsh
```

## Symptom → cause

| Symptom | Cause / fix |
| --- | --- |
| `command not found: eza` on every `cd` | zsh `cd()` wraps eza — `brew install eza` (installer does this) |
| zsh startup prints clone messages | plugins cloning on first launch; normal once, or pre-clone via installer |
| `z` doesn't jump | zoxide missing or `zsh/zoxide.zsh` absent — it must exist and `eval "$(zoxide init zsh)"` |
| tmux status bar plain / plugins dead | tpm missing at `~/.config/tmux/.tmux/plugins/tpm` (note the `.tmux/` segment). Clone it there, then `prefix + I` or `tpm/bin/install_plugins` |
| tmux `prefix + T`/`prefix + P` do nothing | `~/.local/bin` not symlinked or not on PATH (`zsh/macos_config.zsh` appends it) |
| nvim errors on launch | `nvim --headless "+Lazy! sync" +qa`, then `:Mason` for LSPs. Treesitter compile errors mean Xcode CLT is missing |
| option key stopped acting as ctrl after reboot | hidutil mappings reset on reboot. LaunchAgent must be loaded: `launchctl load ~/Library/LaunchAgents/com.larry-lime.remap-keys.plist`; apply now with `/bin/zsh ~/.dotfiles/scripts/on-login.sh` |
| `ZDOTDIR` empty / zshrc not loading | `~/.zshenv` isn't the symlink to `~/.dotfiles/.zshenv` |
| stock prompt (`user@host dir %`) in an open terminal | that shell predates the symlinks — `exec zsh`; new terminals are fine if `zsh -i -c 'whence git_info'` succeeds |
| Ghostty cmd shortcuts dead | they send `\x06X` (Ctrl-F + key) into tmux — user must be inside tmux, prefix must be `C-f` (`tmux show-option -g prefix`), and the target binding must exist (`tmux list-keys -T prefix X`). Reload Ghostty config with `cmd+shift+,`. Validate config: `/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config` |
| `cmd+d` / `cmd+g` popups fail | `lazydocker` / `lazygit` not installed |
| mouse-drag copy does nothing | `tmux-settings.conf` must pipe to `pbcopy` on macOS (`xsel` is the Linux branch) |
| `wt` shows no/missing worktrees | run `~/.dotfiles/scripts/setup-henry-worktrees.sh` (see setup-henry-worktrees skill) |
| submodule dirs empty | `git -C ~/.dotfiles submodule update --init --recursive` |

## Structure facts (avoid wrong "fixes")

- `nvim/`, `tmux/`, `zsh/` are **git submodules** — config fixes there must be committed in the submodule repo AND the pinned commit updated in the superproject, or fresh clones won't get them.
- `~/.local/bin` IS the repo's `.local/bin` (symlink) — files created there land in the repo working tree.
- `zsh/plugins/` and `tmux/.tmux/` are gitignored — cloned plugin content never dirties the submodules.
- The `claude` symlink in `.local/bin` points to a machine-specific version path and may be dangling on a new machine; harmless because `~/.local/bin` is appended (not prepended) to PATH.
