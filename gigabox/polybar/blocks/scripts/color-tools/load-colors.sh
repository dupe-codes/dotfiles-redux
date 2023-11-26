#!/usr/bin/env bash

SAVED_COLORS_DIR="$HOME/.config/polybar/blocks/saved-colors"
CURRENT_COLORS_FILE="$HOME/.config/polybar/blocks/colors.ini"

load_saved_config() {
    dir="~/.config/polybar/blocks/scripts/rofi"
    rofi_command="rofi -no-config -theme $dir/utilscripts.rasi"
    config_name=$(ls "$SAVED_COLORS_DIR" | $rofi_command -i -dmenu -p "Select a saved colors config: ")

    if [ -z "$config_name" ]; then
        exit 1
    fi

    selected_config_file="${SAVED_COLORS_DIR}/${config_name}"

    if [ ! -f "$selected_config_file" ]; then
        notify-send "The selected color config does not exist."
        exit 1
    fi

    cp "$selected_config_file" "$CURRENT_COLORS_FILE"

    if [ -f "$CURRENT_COLORS_FILE" ]; then
        notify-send "Loaded the colors config from '${config_name}'"
    else
        notify-send "Failed to load the colors config."
    fi

    bash $HOME/.config/polybar/blocks/launch.sh &

}

load_saved_config
