# Dotfiles Repo

## Ubuntu Installation
1. Install Essential Packages
    ```shell
    sudo apt install awesome xterm kitty xinit firefox
    ```
2. Change default shell to Z-Shell
    ```shell
    chsh -s $(which zsh)
    ```
3. Install Rust
    ```shell
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    ```
    Follow instructions [here](https://www.rust-lang.org/tools/install) 
4. Install Node
    Follow instructions [here](https://github.com/nodesource/distributions/blob/master/README.md#debinstall) 
5. Install Terminal Tools
    ```shell
    sudo apt install fzf bat && cargo install fd-find ripgrep exa
    ```
6. Build Neovim
    ```shell
    sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
    git clone https://github.com/neovim/neovim
    cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    ```

## Installation
1. Clone the repository
    ```shell
    git clone --recurse-submodules <github-repo-url>
    ```
2. *Run the install script

## Create Symlinks
ln -s ~/.dotfiles/.local/bin/* ~/.local/bin
ln -s ~/.dotfiles/zsh ~/.local/bin
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/tmux ~/.config/zsh
ln -s ~/.dotfiles/awesome ~/.config/awesome
ln -s ~/.dotfiles/kitty/* ~/.config/kitty
...
