# Install Essential Tools
sudo apt update
sudo dmenu zsh fzf bat gh 
# Change Default Shell to Zsh
chsh -s $(which zsh)

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Node
curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

# Installing Useful CLI Tools
cargo install fd-find ripgrep exa

# Building Neovim
sudo apt-get install build-essential ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen

# Check if Builds directory exists. If it doesn't make it and install neovim there
mkdir ~/Builds
git clone https://github.com/neovim/neovim ~/Builds/neovim
cd ~/Builds/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# Source Z-Shell
source ~/.config/zsh/.zshrc

# Install Tmux Plugin Manager
mkdir ~/.dotfiles/tmux/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.dotfiles/tmux/.tmux/plugins/tpm

# Creating Symlinks for files
ln -s ~/.dotfiles/.fzf.zsh ~/.fzf.zsh
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
rm ~/.zshenv && ln -s ~/.dotfiles/.zshenv ~/.zshenv

# Creating Symlinks for directories
ln -s ~/.dotfiles/.local/bin ~/.local/bin
ln -s ~/.dotfiles/zsh ~/.config/zsh
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/tmux ~/.config/tmux
ln -s ~/.dotfiles/awesome ~/.config/awesome
rmdir ~/.config/kitty && ln -s ~/.dotfiles/kitty ~/.config/kitty

cd ~ && mkdir Projects Documents Downloads Github-Repos Work