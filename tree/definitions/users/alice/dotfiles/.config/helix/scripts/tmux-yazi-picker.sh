#!/usr/bin/env bash
buffer_name="$1"
tmpfile=$(mktemp)
yazi "$buffer_name" --chooser-file="$tmpfile"

if [[ -s "$tmpfile" ]]; then
    tmux last-window
    tmux send-keys Escape
    tmux send-keys ":open "
    tmux set-buffer -- "$(tr '\n' ' ' < "$tmpfile")"
    tmux paste-buffer -p -d
    tmux send-keys Enter
fi
rm -f "$tmpfile"
