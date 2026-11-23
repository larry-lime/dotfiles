---
name: henry-worktrees
description: How Lawrence lays out and uses git worktrees for the Henry repo at ~/HenryLabs/henry — 24 persistent Greek-letter slots (alpha..omega) for primary project work and checking out teammates' PRs, base checkouts (dev, main), and disposable Claude Code temp worktrees (.claude/worktrees/*) cleaned up with `wt gc`. Use whenever work involves the Henry repo's worktrees: starting code work, picking or freeing a slot, checking out a PR or teammate branch, "which worktree", "clean up worktrees", "wt", "wt gc", a slot showing "no PR", or deciding where a Claude session or subagent should do its work.
---

# Henry worktrees

Everything lives under `~/HenryLabs/henry/`, one git repo with many worktrees. `dev/` holds the actual clone (`.git`); every other directory is a linked worktree. Each worktree has exactly one of three roles, decided by its **path**:

| Kind | Path | Lifetime | Who uses it |
| --- | --- | --- | --- |
| **slot** | `henry/<greek letter>` — alpha … omega (24) | permanent; never delete | Lawrence's primary project work, checking out teammates' PRs |
| **base** | `henry/dev`, `henry/main` | permanent, stay on their branch | reading/running the current branch |
| **temp** | `*/.claude/worktrees/*`, or any tmp dir (`/private/tmp`, `/var/folders`) | disposable | Claude Code sessions (`claude --worktree`, EnterWorktree), subagents (`isolation: "worktree"`), batch jobs |

Never create other kinds of worktree directories (no new names next to the slots, no `foo-checkout` copies).

## The slot rule

**A slot is on a branch only while that branch has an open PR or draft PR (or is part of an open `gh stack`).** Otherwise it sits idle: detached HEAD at `origin/dev`.

- `wt ls` (or the cmd+t picker) shows each slot as `α alpha  <branch>  #<PR>`, `idle`, or a red **no PR** — red means the rule is broken. Don't silently fix it: ask whether to open a (draft) PR for the branch or free the slot.
- A PR by someone else shows `@author`. Those are teammate checkouts for review/testing — don't commit or push to a teammate's branch unless asked.

### Picking a slot

Use the first `idle` slot in alphabet order (`wt ls | grep idle`). Then:

```sh
cd ~/HenryLabs/henry/<slot>
git fetch origin
# new work:            git switch -c lawrence/<ticket>-<slug> origin/dev
# teammate / any PR:   gh pr checkout <number>
bun install --frozen-lockfile        # slots share Bun's global cache; ~6s
```

Copy any `.env.local` files the task needs from `henry/main`. Open a draft PR early (`gh pr create --draft`, or `gh stack submit` for a stack) so the slot satisfies the rule. `gh stack` state is per-worktree; resume an existing stack in a slot with `gh stack checkout <stack#>`.

If `git switch`/`gh pr checkout` says the branch is already checked out elsewhere, `git worktree list | grep <branch>` shows where — work there instead of forcing.

### Freeing a slot

When its PR merges or closes (or Lawrence says to drop the work):

```sh
cd ~/HenryLabs/henry/<slot>
git status --porcelain                 # must be empty — otherwise stop and ask
git fetch origin && git switch --detach origin/dev
```

The branch stays local; nothing is lost. **Never** `reset --hard`, `clean -fdx`, or delete a slot directory without explicit approval. In the picker, ⌫ on an empty query detaches the selected worktree.

## Where Claude does work

- **Default for Claude-driven code work: a temp worktree.** Start with `claude --worktree <short-name>` from `~/HenryLabs/henry/main`, or the EnterWorktree tool mid-session. Claude Code puts it in `.claude/worktrees/<name>` on branch `worktree-<name>`; rename to `lawrence/<ticket>-<slug>` (`git branch -m`) before pushing. Run `bun install --frozen-lockfile` first.
- **Use a slot instead when** Lawrence asks for one, when checking out a PR/teammate branch for him to look at, or when the work is a long-running project he'll keep coming back to in his own terminal.
- **Subagents and batch work** (build agents, `/self-heal-methods`, `/build-discovery-methods`, …) always use `isolation: "worktree"` or `mktemp -d` — never a slot, never `dev`/`main`.
- Say which worktree you're using when you start.

## Temp worktree cleanup — `wt gc`

`wt gc` checks every temp worktree and removes the ones that are safe:

| State | Default | With flag |
| --- | --- | --- |
| clean, nothing unpushed, no open PR | **removed** | — |
| branch has an open PR | kept | `--all` removes |
| uncommitted changes / unpushed commits / locked / git activity in the last 2h | kept | `--force` removes |
| open in a tmux pane, a running process's cwd, or your current dir | kept | never removed |

It refreshes open PRs from GitHub first, asks before removing (`-y` skips), kills tmux sessions rooted there, and runs `git worktree prune`. Branches are kept, except leftover `worktree-*` branches with nothing unpushed. `--dry-run` / `-n` shows the plan only.

Claude Code locks a worktree while a session is using it, so `locked` usually means "someone is in there" — don't `--force` past a lock without asking.

When asked to clean up: run `wt gc --dry-run`, show the result, then `wt gc -y` once Lawrence agrees. Only use `--all`/`--force` when he asks for them by name.

## Starting work from Linear — `linav` (cmd+l) and `wt open`

Ghostty cmd+l → tmux prefix+O → `linav` in a popup: Lawrence's projects (the "Led by Lawrence" view), ctrl-a for everyone's, enter for a project's issues, enter on an issue to check its branch out. That runs `wt open <branch> [pr#]`: it jumps to the worktree already on the branch, otherwise puts the branch in the first idle slot (`gh pr checkout` when a PR exists, else tracks `origin/<branch>`, else creates it from `origin/dev`), runs `bun install`, and opens the slot's session. A new branch in a slot has no PR yet — open a draft PR to satisfy the slot rule. Data comes from the Linear API (key in the Keychain, service `linear-api-key`), cached in `~/.cache/linav`.

## The `wt` picker (cmd+t)

Ghostty cmd+t → tmux prefix+W → `wt` in a popup. Slots first (`α alpha`…`ω omega`, cyan), then base (`◆`), then temp (`⏳`, dimmed). Enter opens/attaches a tmux session rooted at the worktree (named `α alpha` or `⏳ <name>`; existing sessions are matched by path, so priority-emoji renames are fine). `ctrl-x` deletes the selected temp worktree, `ctrl-g` runs `wt gc`.

## Setup / repair

- `~/.dotfiles/scripts/setup-henry-worktrees.sh` (idempotent) creates dev/main/staging and all 24 slots, detached at `origin/dev`, with deps installed.
- Slot dir deleted by hand → `git -C ~/HenryLabs/henry/dev worktree prune`, then re-run the script.
- Source of truth for `wt`: `~/.dotfiles/.local/bin/wt`; this skill: `~/.dotfiles/claude/skills/henry-worktrees/`.
