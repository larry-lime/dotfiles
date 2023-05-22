# Install Zsh
sudo apt update
sudo apt install zsh cargo
# Install Essential Tools
xcode-select --install
brew install fzf bat gh fd ripgrep exa tmux node neovim kitty

# Change Default Shell to Zsh
chsh -s $(which zsh)

brew install fzf bat gh node ripgrep exa fd neovim tmux lazygit

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Source Z-Shell
source ~/.config/zsh/.zshrc

# Install Tmux Plugin Manager
mkdir ~/.dotfiles/tmux/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.dotfiles/tmux/.tmux/plugins/tpm

# Checkout the correct git branchs
cd ~/.dotfiles/nvim && git checkout ubuntu-amd
cd ~/.dotfiles/zsh && git checkout ubuntu-amd
cd ~/.dotfiles/tmux && git checkout ubuntu-amd

# Creating Symlinks for files
ln -s ~/.dotfiles/.fzf.zsh ~/.fzf.zsh
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.zshenv ~/.zshenv

# Creating Symlinks for directories
ln -s ~/.dotfiles/.local/bin ~/.local/bin
ln -s ~/.dotfiles/zsh ~/.config/zsh
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/tmux ~/.config/tmux
ln -s ~/.dotfiles/awesome ~/.config/awesome
ln -s ~/.dotfiles/kitty ~/.config/kitty
