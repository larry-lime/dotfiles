# Dotfiles Repo

## Installation
1. Install Libraries
```shell
sudo apt update
sudo apt install curl git htop
sudo apt install gnome-tweaks gnome-shell-extensions
```
2. Install Configurations
    ```shell
    git clone --recurse-submodules https://github.com/larry-lime/dotfiles
    cd ~/.dotfiles
    git checkout ubuntu-amd
    ./install.sh
    ```
## Additional Apps
```shell
sudo snap install lazygit
```
### Security
sudo apt-get install cryptsetup
sudo apt install awesome
