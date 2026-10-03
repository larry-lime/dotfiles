git_info() {
    # Find the top-level of the work-tree, if we are in one.
    # This command is the key: it succeeds in a work-tree and fails in a bare repo's directory.
    local work_tree
    work_tree=$(git rev-parse --show-toplevel 2>/dev/null)
    local is_in_work_tree=$?

    # CASE 1: We are in a work-tree (standard repo or `git worktree add` location)
    if [[ $is_in_work_tree -eq 0 ]]; then
        local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD)
        local display_path

        if [[ "$PWD" == "$work_tree" ]]; then
            # We are at the root of the work-tree. Just show its name.
            display_path=$(basename "$work_tree")
        else
            # We are in a subdirectory. Show "root_name/relative/path".
            local rel_path=${PWD#"$work_tree/"}
            display_path="$(basename "$work_tree")/$rel_path"
        fi
        
        echo "%F{cyan}$display_path%f on %F{magenta} $branch%f"
        return
    fi

    # CASE 2: We are NOT in a work-tree. Check if it's because we're in a bare repo.
    if git rev-parse --is-bare-repository >/dev/null 2>&1; then
        echo "%F{cyan}$(basename "$PWD")%f %F{yellow}(bare)%f"
        return
    fi

    # CASE 3: Not in a git repo at all.
    echo "%F{cyan}%~%f"
}

# Set the prompt
setopt PROMPT_SUBST
PROMPT='$(git_info)
%F{green}➜ '
