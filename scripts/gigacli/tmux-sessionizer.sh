#!/usr/bin/env bash

# Adapted from ThePrimeagen (ty!!)
# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$( \
        printf "gigacli\n$(find ~/projects -mindepth 1 -maxdepth 1 -type d)" \
        | gum filter --placeholder "Choose session..." --height 50 --no-strict \
    )
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [ $selected_name = "gigacli" ]; then
    windows=("code" "terminal A" "terminal B" "timer" "calm" "jams")
else
    windows=("code" "terminal A" "terminal B")
fi


if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -ds $selected_name -c $selected -n "${windows[0]}"
    for window in "${windows[@]:1}"; do
        tmux new-window -t "$selected_name" -n "$window" -c "$selected"
    done
    tmux attach-session -t "$selected_name":1
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected -n "${windows[0]}"
    for window in "${windows[@]:1}"; do
        tmux new-window -t "$selected_name" -n "$window" -c "$selected"
    done
fi

if [[ -z $TMUX ]]; then
    tmux attach-session -t "$selected_name":1
else
    tmux switch-client -t "$selected_name":1
fi
