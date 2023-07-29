#!/usr/bin/env bash

safeeyes_running=$(pgrep -x safeeyes)
if [ -z "$safeeyes_running" ]; then
    safeeyes &
    notify-send "Safe Eyes" "Started!"
    exit 0
fi

if [[ $(safeeyes --status) == *"Disabled"* ]]; then
    safeeyes --enable
    notify-send "Safe Eyes" "Toggled to enabled"
else
    # Otherwise, disable it
    safeeyes --disable
    notify-send "Safe Eyes" "Toggled to disabled"
fi

