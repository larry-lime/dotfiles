#     _    _ _
#    / \  | (_) __ _ ___  ___  ___
#   / _ \ | | |/ _` / __|/ _ \/ __|
#  / ___ \| | | (_| \__ \  __/\__ \
# /_/   \_\_|_|\__,_|___/\___||___/

# -----------------------
# REMAPPED SHELL COMMANDS
# -----------------------

alias ls="eza"
alias ll="eza -l -snew"
alias la="eza -a"
alias tree="eza -T --icons"
# alias cat="bat"
# alias z="zoxide"

# ------------------------
# SHORTENED SHELL COMMANDS
# ------------------------

alias o="open"
alias md="mkdir"
alias rd="rmdir"
alias cl="clear"

# --------------
# DIRECTORY SHORTCUTS
# --------------

alias down="cd $HOME/Downloads"
alias doc="cd $HOME/Documents"

# --------------------
# RUN AND SOURCE FILES
# --------------------

alias tnav="source ~/.dotfiles/.local/bin/tnav"
alias tsource="tmux source ~/.config/tmux/tmux.conf"
alias sep="/Users/lawrencelim/Scripts/generate-separator.sh"
alias so="source ~/.config/zsh/.zshrc"

# ------------------
# SHORTENED COMMANDS
# ------------------

alias nv="nvim"
alias vim="nvim"
alias ne="neovide"
alias leet="nvim leetcode.nvim"
alias t="tmux"
alias hg="hugo"
alias lg="lazygit"
alias lzd='lazydocker'
alias lw="lazyworktree"
alias wts="wtsync"          # fast-forward the main/staging/dev worktrees
alias py="python3"
alias ipython="python3 -m IPython"
alias code="code-insiders"

alias \?\?="gh copilot suggest -t shell "
alias git\?="gh copilot suggest -t git"
alias gh\?="gh copilot suggest -t gh"

alias c='claude'

# Remote LazyDocker
alias lzd-l1='DOCKER_HOST=ssh://l1 lazydocker'
alias lzd-w1='DOCKER_HOST=ssh://w1 lazydocker'
alias lzd-w2='DOCKER_HOST=ssh://w2 lazydocker'
alias lzd-wp='DOCKER_HOST=ssh://wp lazydocker'

# Henry AWS boxes via SSM Session Manager
alias ssm-dev='aws ssm start-session --target i-00f0b927312a12b47'
alias ssm-staging='aws ssm start-session --target i-082f0be272651d9fd'
alias ssm-prod='aws ssm start-session --target i-07736941857d6f004'
