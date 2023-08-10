#!/usr/bin/env bash

if [ "$(dunstctl is-paused)" = "false" ]; then
    notify-send "Notifications" "Paused "
    sleep 10s
else
    notify-send "Notifications" "Resumed "
fi

dunstctl set-paused toggle

