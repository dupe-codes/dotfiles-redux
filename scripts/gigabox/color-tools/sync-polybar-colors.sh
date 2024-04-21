#!/usr/bin/env bash

# Retrieve the current wallpaper set by nitrogen
get_current_wallpaper() {
    grep -E '^file=' ~/.config/nitrogen/bg-saved.cfg | cut -d'=' -f2-
}

WALLPAPER_PATH=$(get_current_wallpaper)
bash $HOME/scripts/gigabox/color-tools/pywal.sh "$WALLPAPER_PATH"
