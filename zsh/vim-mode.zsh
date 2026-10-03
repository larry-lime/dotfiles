# __     ___             __  __           _      
# \ \   / (_)_ __ ___   |  \/  | ___   __| | ___ 
#  \ \ / /| | '_ ` _ \  | |\/| |/ _ \ / _` |/ _ \
#   \ V / | | | | | | | | |  | | (_) | (_| |  __/
#    \_/  |_|_| |_| |_| |_|  |_|\___/ \__,_|\___|


# ---------------------------
# VIM MODE FROM CHRIS@MACHINE
# ---------------------------

# bindkey -e will be emacs mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
