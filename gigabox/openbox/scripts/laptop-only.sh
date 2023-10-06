#!/usr/bin/env bash

# Configure displays
xrandr --output eDP-1 --mode 2256x1504 --primary --output DP-1 --off --output DP-2 --off
sleep 2s && nitrogen --restore &

## Launch Polybar
bash ~/.config/polybar/blocks/launch.sh

. $HOME/.gigabox
xset r rate $KEYBOARD_REPEAT_DELAY $KEYBOARD_REPEAT_RATE # keyboard repeat delay and interval

# Retrieve the current wallpaper set by nitrogen
get_current_wallpaper() {
    grep -E '^file=' ~/.config/nitrogen/bg-saved.cfg | cut -d'=' -f2-
}

WALLPAPER_PATH=$(get_current_wallpaper)
bash ~/.config/polybar/blocks/scripts/pywal.sh "$WALLPAPER_PATH"

