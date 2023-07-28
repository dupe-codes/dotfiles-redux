#!/usr/bin/env bash

# Configure displays
xrandr --output eDP-1 --mode 2256x1504 --primary --output DP-1 --off --output DP-2 --off
sleep 2s && nitrogen --restore &

## Launch Polybar
bash ~/.config/polybar/blocks/launch.sh

. $HOME/.gigabox
xset r rate $KEYBOARD_REPEAT_DELAY $KEYBOARD_REPEAT_RATE # keyboard repeat delay and interval

