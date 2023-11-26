#!/usr/bin/env bash

get_current_wallpaper() {
    grep -E '^file=' ~/.config/nitrogen/bg-saved.cfg | cut -d'=' -f2-
}

save_wallpaper=" Save wallpaper as favorite"
load_wallpaper=" Load favorite wallpaper"

options="$save_wallpaper\n\
$load_wallpaper\n"

dir="~/.config/polybar/blocks/scripts/rofi"
rofi_command="rofi -no-config -theme $dir/utilscripts.rasi"
chosen="$(echo -e "$options" | $rofi_command -i -p "Run" -dmenu -selected-row 0)"

favorites_file="$HOME/projects/dotfiles-redux/gigabox/favorite-wallpapers.txt"
wallpapers_dir="$HOME/projects/dotfiles-redux/gigabox/resources/wallpapers"

case $chosen in
    $save_wallpaper)
        WALLPAPER_PATH=$(get_current_wallpaper)
        WALLPAPER_NAME=$(basename "$WALLPAPER_PATH")
        touch "$favorites_file"
        if grep -Fxq "$WALLPAPER_NAME" "$favorites_file"; then
            notify-send "Wallpaper" "$WALLPAPER_NAME is already a favorite."
        else
            echo "$WALLPAPER_NAME" >> "$favorites_file"
            notify-send "Wallpaper" "$WALLPAPER_NAME saved as favorite."
        fi
        ;;
    $load_wallpaper)
        if [ -f "$favorites_file" ]; then
            selection=$(cat "$favorites_file" | $rofi_command -dmenu -i -p "Select wallpaper")
            if [ -n "$selection" ]; then
                nitrogen --set-zoom-fill --save "$wallpapers_dir/$selection"
                notify-send "Wallpaper" "$selection loaded."
            fi
        else
            notify-send "Wallpaper" "No favorite wallpapers found."
        fi
        ;;
esac
