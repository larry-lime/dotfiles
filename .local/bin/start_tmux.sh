#!/bin/bash

tmux rename-session -t 0 'config'
tmux rename-window 'nvim'
tmux send-keys -t config:nvim "z $HOME/.dotfiles/nvim && nvim" C-m
tmux neww -n 'zsh' -c "$HOME/.dotfiles/zsh"
tmux neww -n 'tmux' -c "$HOME/.dotfiles/tmux"
tmux send-keys -t config:zsh "nvim" C-m
tmux send-keys -t config:tmux "nvim" C-m
