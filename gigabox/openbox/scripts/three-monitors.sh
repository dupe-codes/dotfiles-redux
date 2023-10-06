#!/usr/bin/env bash

# Configure displays
xrandr --output eDP-1 --mode 2256x1504 --right-of DP-1 --output DP-1 --primary --mode 2560x1440 --output DP-2 --mode 2560x1440 --left-of DP-1 --rotate left
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

