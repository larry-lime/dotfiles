---
name: setup-henry-worktrees
description: Set up or repair the Henry work repo worktree layout at ~/HenryLabs/henry (dev, main, staging, alpha–zeta). Use when the user mentions setting up henry, work repo worktrees, or wt showing missing worktrees.
---

# Henry worktree layout

Target layout, produced by `~/.dotfiles/scripts/setup-henry-worktrees.sh` (idempotent, also run by `install.sh`):

```
~/HenryLabs/henry/
  dev/       main worktree — the actual clone, tracks origin/dev
  main/      linked worktree, tracks origin/main
  staging/   linked worktree, tracks origin/staging
  alpha/ beta/ gamma/ delta/ epsilon/ zeta/
             scratch worktrees — local branches (no upstream) based off origin/dev
```

## Running it

```sh
~/.dotfiles/scripts/setup-henry-worktrees.sh
```

- Repo is private (`Henry-Social/henry`) — needs GitHub auth first (`gh auth login`).
- A plain clone already at `~/HenryLabs/henry` is converted in place: it becomes `dev/`. The script **aborts if the clone has any uncommitted or untracked changes** — never force this; have the user commit/stash first.
- Existing worktree dirs are skipped, never recreated.

## How it's used

- `wt` (`~/.local/bin/wt`, bound to `prefix+W` in tmux / `cmd+t` in Ghostty) lists all worktrees via fzf and switches to a tmux session rooted at the chosen one. Run from any worktree or from `~/HenryLabs/henry` itself (it scans subdirs when the cwd isn't a worktree).
- Branch promotion flow (zsh `ghpr` function): feature → preview → staging → main.
- Scratch worktrees (alpha–zeta) are for parallel feature work; reset one with
  `git -C ~/HenryLabs/henry/alpha fetch origin && git -C ~/HenryLabs/henry/alpha reset --hard origin/dev` (confirm with the user first — this discards work).

## Repair notes

- Worktree dir deleted manually → `git -C ~/HenryLabs/henry/dev worktree prune`, then re-run the script.
- "branch already checked out" errors → each branch can only be checked out in one worktree; `git worktree list` to find where.
