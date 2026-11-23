#!/bin/bash
# Set up the Henry work repo as a worktree farm at ~/HenryLabs/henry:
#
#   ~/HenryLabs/henry/
#     dev/       <- main worktree (primary checkout, tracks origin/dev)
#     main/      <- worktree, tracks origin/main
#     staging/   <- worktree, tracks origin/staging
#     alpha/ .. omega/ <- 24 persistent slots, detached at origin/dev when idle
#
# A slot is checked out on a branch only while that branch has an open PR
# (yours or a teammate's). Temp worktrees (Claude Code's .claude/worktrees/*)
# are separate and disposable: `wt gc` cleans them up.
#
# Idempotent. If ~/HenryLabs/henry is an existing plain clone, it is converted
# in place (moved to become the dev/ worktree) — but only if fully clean,
# including untracked files, so nothing can be lost.
#
# `wt` (prefix+W / cmd+t) run from any of these dirs, or from the parent,
# picks up every worktree.

set -uo pipefail

REPO_URL="https://github.com/Henry-Social/henry"
ROOT="$HOME/HenryLabs/henry"
CORE_BRANCHES=(main staging)          # dev is the main worktree
SLOTS=(alpha beta gamma delta epsilon zeta eta theta iota kappa lambda mu nu xi omicron pi rho sigma tau upsilon phi chi psi omega)
BASE_BRANCH="dev"                     # idle slots sit detached at origin/$BASE_BRANCH

info()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
ok()    { printf '\033[1;32m ✓ \033[0m %s\n' "$*"; }
warn()  { printf '\033[1;33m ! \033[0m %s\n' "$*"; }
fail()  { printf '\033[1;31m ✗ \033[0m %s\n' "$*"; exit 1; }

DEV="$ROOT/dev"

# ---------------------------------------
# 1. Get the repo into the dev/ worktree
# ---------------------------------------

if [[ -d "$DEV/.git" || -f "$DEV/.git" ]]; then
  ok "dev worktree already at $DEV"
elif [[ -d "$ROOT/.git" ]]; then
  # Existing plain clone at $ROOT — convert it to the parent/worktree layout.
  info "Converting existing clone at $ROOT into worktree layout"
  if [[ -n "$(git -C "$ROOT" status --porcelain)" ]]; then
    fail "$ROOT has uncommitted or untracked changes — commit/stash them, then re-run"
  fi
  TMP="$HOME/HenryLabs/.henry-convert-$$"
  mv "$ROOT" "$TMP" || fail "could not move $ROOT"
  mkdir -p "$ROOT"
  mv "$TMP" "$DEV" || fail "could not move clone into $DEV"
  ok "Existing clone is now $DEV"
elif [[ ! -e "$ROOT" ]]; then
  info "Cloning $REPO_URL"
  mkdir -p "$ROOT"
  git clone "$REPO_URL" "$DEV" || { rmdir "$ROOT" 2>/dev/null; fail "clone failed — authenticate first (gh auth login) and re-run"; }
else
  fail "$ROOT exists but is neither a clone nor the worktree layout — inspect it manually"
fi

# Make sure the main worktree is on the base branch
current_branch=$(git -C "$DEV" branch --show-current)
if [[ "$current_branch" != "$BASE_BRANCH" ]]; then
  git -C "$DEV" switch "$BASE_BRANCH" 2>/dev/null || git -C "$DEV" switch -c "$BASE_BRANCH" --track "origin/$BASE_BRANCH" || warn "could not switch dev worktree to $BASE_BRANCH (currently on $current_branch)"
fi

info "Fetching origin"
git -C "$DEV" fetch origin --prune || warn "fetch failed — worktrees will be created from local refs"

# ----------------------------------------
# 2. Core branch worktrees (main, staging)
# ----------------------------------------

info "Creating core worktrees: ${CORE_BRANCHES[*]}"
for b in "${CORE_BRANCHES[@]}"; do
  if [[ -d "$ROOT/$b" ]]; then
    ok "$b (exists)"
  elif git -C "$DEV" show-ref --verify --quiet "refs/heads/$b"; then
    git -C "$DEV" worktree add "$ROOT/$b" "$b" && ok "$b" || warn "$b failed"
  else
    git -C "$DEV" worktree add --track -b "$b" "$ROOT/$b" "origin/$b" && ok "$b (tracking origin/$b)" || warn "$b failed"
  fi
done

# ----------------------------------------------------------
# 3. Slot worktrees (alpha..omega, detached at origin/dev)
# ----------------------------------------------------------

info "Creating slot worktrees (detached at origin/$BASE_BRANCH): ${SLOTS[*]}"
for s in "${SLOTS[@]}"; do
  if [[ -e "$ROOT/$s" ]]; then
    ok "$s (exists)"
    continue
  fi
  if git -C "$DEV" worktree add --detach "$ROOT/$s" "origin/$BASE_BRANCH" >/dev/null 2>&1; then
    if command -v bun >/dev/null 2>&1 && (cd "$ROOT/$s" && bun install --frozen-lockfile >/dev/null 2>&1); then
      ok "$s (deps installed)"
    else
      ok "$s (run 'bun install --frozen-lockfile' in it before use)"
    fi
  else
    warn "$s failed"
  fi
done

echo
info "Worktrees:"
git -C "$DEV" worktree list
