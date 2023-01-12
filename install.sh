# Install Essential Tools
xcode-select --install
brew install fzf bat gh fd ripgrep exa tmux node neovim kitty

# Change Default Shell to Zsh
chsh -s $(which zsh)

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


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
