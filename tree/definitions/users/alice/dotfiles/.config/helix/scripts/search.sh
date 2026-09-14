#!/usr/bin/env bash

paths=$(read -rp "pattern: " p && rg --line-number --no-heading --column --color=never "$p" | fzf | awk -F: '{print $1 ":" $2 ":" $3}'
)

if [[ -n "$paths" ]]; then
    tmux last-window
    tmux send-keys Escape
    tmux send-keys ":o $paths"
    tmux send-keys Enter
else
    tmux kill-window -t fx
fi
