#!/usr/bin/env bash
# Usage: session-prio.sh <session_id> [emoji]
# Strips any existing priority emoji from the session name, then prepends [emoji].
target="$1"
emoji="$2"
name=$(tmux display-message -p -t "$target" '#{session_name}')
for e in 🟢 🟡 🔴 🚨; do name="${name#"$e "}"; done
[ -n "$emoji" ] && name="$emoji $name"
tmux rename-session -t "$target" -- "$name"
