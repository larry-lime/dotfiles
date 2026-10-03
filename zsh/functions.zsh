#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/

# --------------
# PLUGIN MANAGER
# --------------

function zsh_add_file() {
    # Function to source files if they exist
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For plugins
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
            zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

function zsh_add_completion() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For completions
        completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        fpath+="$(dirname "${completion_file_path}")"
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
        fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
    fi
    completion_file="$(basename "${completion_file_path}")"
    if [ "$2" = true ] && compinit "${completion_file:1}"
}

# -------------------
# CUSTOM ZSH COMMANDS
# -------------------

function oj() {
    if [ $# -eq 0 ]; then
        jobs -d
    else
        fg %$1
    fi
}

function kj ()
{
    kill %$1
}

# FIXME: So this works on linux
function cpath() {
    # use pbcopy if on mac and xclip if on linux
    # if on macos, set the command to pbcopy elese set it to xclip
      [[ $OSTYPE == "darwin"* ]] && alias copy='pbcopy' || alias copy='xclip -selection clipboard'

      # if OS is macos, then copy the path of the current directory
      if [[ $# -eq 0 ]]; then
          echo $(pwd) | tr "\n" " " | pbcopy
      else
          if [[ -f $1 ]]; then
              echo $(pwd)/$1 | tr "\n" " " | pbcopy
          elif [[ -d $1 ]]; then
              echo $(pwd)/$1 | tr "\n" "/" | pbcopy
          fi
      fi
  }

function cd ()
{
  builtin cd "$@" || return
  eza
  # echo $(pwd) | tr "\n" " " | pbcopy
}

function ghpr (){
    # Parse arguments
    draft_flag=""
    base_branch=""
    title=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --draft)
                draft_flag="--draft"
                shift
                ;;
            *)
                if [[ -z "$base_branch" ]]; then
                    base_branch="$1"
                elif [[ -z "$title" ]]; then
                    title="$1"
                fi
                shift
                ;;
        esac
    done

    current_branch=$(git branch --show-current)

    # Auto-detect base branch if not provided
    # Branch promotion flow: feature -> preview -> staging -> main
    if [[ -z "$base_branch" ]]; then
        case "$current_branch" in
            staging) base_branch="main" ;;
            preview) base_branch="staging" ;;
            *)       base_branch="preview" ;;
        esac
    fi

    # Auto-set title and skip description for promotion PRs
    if [[ "$current_branch" == "preview" && "$base_branch" == "staging" ]]; then
        title="Merge preview into staging"
        gh pr create --base "$base_branch" --title "$title" $draft_flag --body ""
    elif [[ "$current_branch" == "staging" && "$base_branch" == "main" ]]; then
        title="Merge staging into main"
        gh pr create --base "$base_branch" --title "$title" $draft_flag --body ""
    else
        # Feature branch to preview - requires user-provided title and description
        gh pr create --base "$base_branch" --title "$title" $draft_flag --fill
    fi
}


function kp() {
  port=$1
  kill $(lsof -t -i:$port)
}

function ssh() {
    if [[ -n "$TMUX" ]]; then
        local host="${@: -1}"
        host="${host##*@}"
        local display_name="$host"
        case "$host" in
            prod)  display_name="PROD-1-SERVER" ;;
            prod2) display_name="PROD-2-SERVER" ;;
            prev)  display_name="PREV-SERVER" ;;
        esac
        tmux rename-window "$display_name"
        command ssh "$@"
    else
        command ssh "$@"
    fi
}
