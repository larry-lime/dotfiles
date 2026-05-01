# Dotfiles

macOS setup for Ghostty + tmux + Neovim (LazyVim) + Zsh.

## Prerequisites

```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

`.zshenv` sources `$HOME/.cargo/env`, so Rust must be installed (or that line removed).

## Clone

```sh
git clone --recurse-submodules https://github.com/larry-lime/dotfiles ~/.dotfiles
```

`--recurse-submodules` is required — `nvim/`, `tmux/`, and `zsh/` are git submodules.

## Install packages

```sh
brew install tmux neovim fzf ripgrep fd eza sd sesh zoxide lazygit lazydocker gh node
brew install --cask ghostty
```

## Font

Ghostty is configured to use **ComicCodeLigatures Nerd Font** (`ghostty/config:8`). It's a custom Nerd Font patch of the paid Comic Code typeface and is not on a public Homebrew tap — drop the `.ttf` files into `~/Library/Fonts` manually, or edit `ghostty/config` to use any other Nerd Font (e.g. `JetBrainsMono Nerd Font` via `brew install --cask font-jetbrains-mono-nerd-font`).

## Symlinks

```sh
mkdir -p ~/.config ~/.local

ln -sf  ~/.dotfiles/.zshenv     ~/.zshenv
ln -sf  ~/.dotfiles/.tmux.conf  ~/.tmux.conf
ln -sf  ~/.dotfiles/.fzf.zsh    ~/.fzf.zsh
ln -sfn ~/.dotfiles/nvim        ~/.config/nvim
ln -sfn ~/.dotfiles/tmux        ~/.config/tmux
ln -sfn ~/.dotfiles/zsh         ~/.config/zsh
ln -sfn ~/.dotfiles/ghostty     ~/.config/ghostty
ln -sfn ~/.dotfiles/.local/bin  ~/.local/bin
```

## Post-install

1. **tmux plugins** — install tpm and fetch plugins:
   ```sh
   git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
   ```
   Start tmux, then press `prefix + I` to install the rest.

2. **Neovim** — launch `nvim` once. lazy.nvim bootstraps itself and installs plugins. Run `:Mason` to install LSPs/formatters.

3. **PATH** — make sure `~/.local/bin` is on `$PATH` so the scripts (`tnav`, `start_tmux`, `wt`, ...) are reachable. Add to your zsh config if it isn't already:
   ```sh
   export PATH="$HOME/.local/bin:$PATH"
   ```

4. **Ghostty** — open Ghostty; it auto-loads `~/.config/ghostty/config`.

## Layout reference

| Source in repo                | Symlinked to             | Notes                          |
| ----------------------------- | ------------------------ | ------------------------------ |
| `.zshenv`                     | `~/.zshenv`              | sets `ZDOTDIR=~/.config/zsh`   |
| `.tmux.conf`                  | `~/.tmux.conf`           | sources `~/.config/tmux/`      |
| `.fzf.zsh`                    | `~/.fzf.zsh`             | fzf shell integration          |
| `nvim/`                       | `~/.config/nvim`         | submodule (LazyVim fork)       |
| `tmux/`                       | `~/.config/tmux`         | submodule                      |
| `zsh/`                        | `~/.config/zsh`          | submodule                      |
| `ghostty/`                    | `~/.config/ghostty`      | flat config                    |
| `.local/bin/`                 | `~/.local/bin`           | personal scripts               |
| `scripts/`                    | (not symlinked)          | run directly when needed       |
