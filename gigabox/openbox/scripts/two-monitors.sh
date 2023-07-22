#!/usr/bin/env bash

# Configure displays
xrandr --output DP-1 --primary --mode 2560x1440 --output DP-2 --mode 2560x1440 --left-of DP-1 --rotate left --output eDP-1 --off
sleep 2s && nitrogen --restore &

## Launch Polybar
bash ~/.config/polybar/blocks/launch.sh

