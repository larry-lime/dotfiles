#   ____             __ _
#  / ___|___  _ __  / _(_) __ _
# | |   / _ \| '_ \| |_| |/ _` |
# | |__| (_) | | | |  _| | (_| |
#  \____\___/|_| |_|_| |_|\__, |
#                         |___/


# --------------
# PATH VARIABLES
# --------------

export PATH="$PATH:/Users/lawrencelim/.foundry/bin"

# -----------
# GLOBAL VARS
# -----------

export EDITOR="nvim"
export BROWSER="Brave.app" # FIXME: Fix this to be cross-platform
export DOCKER_HOST="unix://$HOME/.colima/docker.sock" # Colima Docker Host

# -----
# EVALS
# -----

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"
