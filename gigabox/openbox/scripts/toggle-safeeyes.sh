#!/usr/bin/env bash

enable_safeeyes() {
    safeeyes --enable
    notify-send "Safe Eyes" "Enabled"
}

disable_safeeyes() {
    local is_snoozed=$1
    safeeyes --disable
    if [ "$is_snoozed" = true ]; then
        notify-send "Safe Eyes" "Snoozed"
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
    # Schedule the enable function to run after 1 hour
    nohup bash -c "sleep 3600; enable_safeeyes" &
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
