#!/usr/bin/env bash

# adapted from ThePrimeagen (ty!!)
# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer
#
# the sessionizer facilitates the creation of and connection to tmux sessions
# linked to target project directories. in addition to this base functionality,
# i've added support for:
#   1. creation of named windows based on my preferred programming setup
#   2. initialization commands for specific project directories, e.g. configuring
#      opam switches for ocaml projects

saved_options=("gigacli" "$HOME/datastore")

if [[ $# -eq 1 ]]; then
    selected=$1
else
    saved_options_string=$(printf "%s\n" "${saved_options[@]}")
    selected=$(
        printf "%s\n%s" "$saved_options_string" "$(find ~/projects -mindepth 1 -maxdepth 1 -type d)" | fzf
    )
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [ "$selected_name" = "gigacli" ]; then
    windows=("code" "term 1" "term 2" "timer" "calm" "jams")
else
    windows=("code" "term 1" "term 2")
fi

# criteria and init commands mapping
# NOTE: for now, all commands must have two criteria to OR check on,
#       the existence of a target dir or target file, and one command to
#       execute when critera is met
declare -A init_commands
init_commands[ocaml]="$selected/_opam;$selected/.opam-switch;opam switch && eval \$(opam env)"

function get_init_commands {
    for key in "${!init_commands[@]}"; do
        IFS=';' read -ra ADDR <<<"${init_commands[$key]}"
        if [[ -d "${ADDR[0]}" ]] || [[ -f "${ADDR[1]}" ]]; then
            echo "${ADDR[2]}"
            return
        fi
    done
}

init_command=$(get_init_commands)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -ds "$selected_name" -c "$selected" -n "${windows[0]}"
    if [[ -n $init_command ]]; then
        tmux send-keys -t "$selected_name:${windows[0]}" "$init_command" C-m
    fi

    for window in "${windows[@]:1}"; do
        tmux new-window -t "$selected_name" -n "$window" -c "$selected"
        if [[ -n $init_command ]]; then
            tmux send-keys -t "$selected_name:$window" "$init_command" C-m
        fi
    done

    tmux attach-session -t "$selected_name":1
    exit 0
fi

if ! tmux has-session -t="$selected_name" 2>/dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected" -n "${windows[0]}"
    if [[ -n $init_command ]]; then
        tmux send-keys -t "$selected_name:${windows[0]}" "$init_command" C-m
    fi

    for window in "${windows[@]:1}"; do
        tmux new-window -t "$selected_name" -n "$window" -c "$selected"
        if [[ -n $init_command ]]; then
            tmux send-keys -t "$selected_name:$window" "$init_command" C-m
        fi
    done
fi

if [[ -z $TMUX ]]; then
    tmux attach-session -t "$selected_name":1
else
    tmux switch-client -t "$selected_name":1
fi
