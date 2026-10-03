#  _  __          _     _           _     
# | |/ /___ _   _| |__ (_)_ __   __| |___ 
# | ' // _ \ | | | '_ \| | '_ \ / _` / __|
# | . \  __/ |_| | |_) | | | | | (_| \__ \
# |_|\_\___|\__, |_.__/|_|_| |_|\__,_|___/
#           |___/                         

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # Source fzf keybinds
bindkey -s '^a' '**	' # fzf autocomplee

bindkey -s '^g' 'wt\n' # worktree switcher

# bindkey '^a' fzf-cd-widget

bindkey -s '^h' 'cd ~\n' # go home
bindkey -s '^b' 'cd ..\n' # go to previous directory

bindkey -s '^_' 'cd /\n' # go to root directory
bindkey '^[[Z' reverse-menu-complete # # Enable shift tab to do reverse select
# bindkey -s '^u' 'cd -\n' # go to last directory
