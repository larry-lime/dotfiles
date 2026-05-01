#!/bin/zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Appearance
# @raycast.mode inline

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Toggle's appearance
# @raycast.author Lawrence Lim
# @raycast.authorURL https://github.com/larry-lime

osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'

# Source environment variables and switch_theme
source $HOME/.dotfiles/zsh/macos_config.zsh
source $HOME/.local/bin/switch_theme
