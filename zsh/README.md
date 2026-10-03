# Z-Shell Config

## Installation

### Requirements

- [fzf](https://github.com/junegunn/fzf): Command line fuzzy finder
- [bat](https://github.com/sharkdp/bat): Cat command replacement
- [eza](https://github.com/ogham/eza): ls replacement
- [ripgrep](https://github.com/BurntSushi/ripgrep): better grep replacement
- [fd](https://github.com/sharkdp/fd): Intuitive find alternative

#### macOs

Homebrew

```shell
brew install fzf bat ripgrep fd eza gh tmux node lazygit
```

#### Ubuntu on ARM

```shell
sudo apt install fzf fd-find
```

#### Ubuntu Linux

fzf

```shell
sudo apt-get install fzf
```

bat

```shell
sudo apt install bat
```

fd

```shell
npm install -g fd-find
```

OR

```shell
cargo install fd-find
```

ripgrep

```shell
cargo install ripgrep
```

eza

```shell
cargo install eza
```

### Config

0. Delete any `~/.config/zsh` directory beforehand
1. Git clone configuration repo

   ```shell
   cd ~/.config/ && git clone https://github.com/larry-lime/zsh-config zsh
   ```

2. Source config to install plugins

   ```shell
   source ~/.config/zsh
   ```

3. Restart your terminal

### Change Colors

Change Kitty colorscheme

```bash
kitten themes
```

Change Neovim colorscheme

```vim
:Telescope colorscheme

```

Change Tmux colorscheme

```txt
18 ▎ set -g @catppuccin_flavour 'latte' # or frappe, macchiato, mocha, latte
```

Change FZF colorscheme

```bash
# FZF_DEFAULT_OPTS=" \
# --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
# --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
# --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

FZF_DEFAULT_OPTS=" \
    --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
    --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
    --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"
```

Change Tnav colorscheme

```bash
# FZF_DEFAULT_OPTS=" \
# --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
# --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
# --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

FZF_DEFAULT_OPTS=" \
    --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
    --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
    --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"
```
