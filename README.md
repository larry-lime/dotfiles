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
sudo visudo <- enabled running sudo without password
sudo apt install dconf-editor xsel dmenu brightnessctl

### Configurations
#### Brightness
usermod -a -G video ${USER}
#### Screen DPI
1) Create the ~/.Xresources file with your settings, that is 
Xft.dpi: 130

2) I needed to include the settings from .Xresources by adding the following line to the file ~/.xinitrc 
xrdb -merge ~/.Xresources
#### Additional Apps
lxappearance
sudo apt install okular

### Ricing my Desktop
sudo apt install gir1.2-gmenu-3.0

