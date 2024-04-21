#!/usr/bin/env bash

sync_polybar_colors=" Sync polybar colors"
save_polybar_colors=" Save polybar colors"
load_polybar_colors=" Load polybar colors"

options="$sync_polybar_colors\n"\
"$save_polybar_colors\n"\
"$load_polybar_colors\n"

dir="$HOME/scripts/gigabox/rofi"
rofi_command="rofi -no-config -theme $dir/utilscripts.rasi"
chosen="$(echo -e "$options" | $rofi_command -i -p "Run" -dmenu -selected-row 0)"

case $chosen in
    $sync_polybar_colors)
        $HOME/scripts/gigabox/color-tools/sync-polybar-colors.sh
        ;;
    $save_polybar_colors)
        $HOME/scripts/gigabox/color-tools/save-colors.sh
        ;;
    $load_polybar_colors)
        $HOME/scripts/gigabox/color-tools/load-colors.sh
        ;;
esac

