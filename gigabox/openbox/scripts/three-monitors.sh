#!/usr/bin/env bash

# Configure displays
xrandr --output eDP-1 --mode 2256x1504 --right-of DP-1 --output DP-1 --primary --mode 2560x1440 --output DP-2 --mode 2560x1440 --left-of DP-1 --rotate left
sleep 2s && nitrogen --restore &

## Launch Polybar
bash ~/.config/polybar/blocks/launch.sh

. $HOME/.gigabox
xset r rate $KEYBOARD_REPEAT_DELAY $KEYBOARD_REPEAD_RATE # keyboard repeat delay and interval

