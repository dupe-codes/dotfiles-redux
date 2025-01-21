#!/usr/bin/env bash

enable_safeeyes() {
    safeeyes --enable
    notify-send "Safe Eyes" "Enabled"
}

disable_safeeyes() {
    local is_snoozed=$1
    safeeyes --disable
    if [ "$is_snoozed" = true ]; then
        notify-send "Safe Eyes" "Snoozed for 1 hour"
    else
        notify-send "Safe Eyes" "Disabled"
    fi
}

safeeyes_running=$(pgrep -x safeeyes)

if [[ "$1" == "--snooze" ]]; then
    if [ -z "$safeeyes_running" ]; then
        notify-send "Safe Eyes" "Safe Eyes is not running"
        exit 0
    fi
    disable_safeeyes true
    # TODO: Clean up path once gigabox + gigacli scripts are consolidated
    #       and properly linked to ~/scripts
    echo "~/projects/dotfiles-redux/gigabox/openbox/scripts/toggle-safeeyes.sh" \
        | at now +1 hours
    exit 0
fi

if [ -z "$safeeyes_running" ]; then
    safeeyes &
    notify-send "Safe Eyes" "Started!"
    exit 0
fi

if [[ $(safeeyes --status) == *"Disabled"* ]]; then
    enable_safeeyes
else
    disable_safeeyes false
fi
