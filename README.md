# Dotfiles Repo

## Installation
1. Install Libraries
```shell
sudo apt install xinit awesome kitty xterm firefox dmenu zsh fzf bat
```
2. Install Configurations
    ```shell
    git clone --recurse-submodules https://github.com/larry-lime/dotfiles ~/.dotfiles && ~/.dotfiles/install-ubuntu-arm.sh
    ```
<!-- ## Ubuntu Installation -->
<!-- 1. Install Essential Packages -->
<!--     ```shell -->
<!--     sudo apt install xinit awesome kitty xterm firefox dmenu zsh fzf bat -->
<!--     startx -->
<!--     ``` -->
<!-- 2. Change default shell to Z-Shell -->
<!--     ```shell -->
<!--     chsh -s $(which zsh) -->
<!--     ``` -->
<!-- 3. Install Rust -->
<!--     ```shell -->
<!--     curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -->
<!--     ``` -->
<!--     Follow instructions [here](https://www.rust-lang.org/tools/install)  -->
<!-- 4. Install Node -->
<!--     ```shell -->
<!--     curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - &&\ -->
<!--     sudo apt-get install -y nodejs -->
<!--     ``` -->
<!--     Follow instructions [here](https://github.com/nodesource/distributions/blob/master/README.md#debinstall)  -->
<!-- 5. Install Terminal Tools -->
<!--     ```shell -->
<!--     cargo install fd-find ripgrep exa -->
<!--     ``` -->
<!-- 6. Build Neovim -->
<!--     ```shell -->
<!--     sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -->
<!--     git clone https://github.com/neovim/neovim -->
<!--     cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo -->
<!--     sudo make install -->
<!--     ``` -->
<!---->
