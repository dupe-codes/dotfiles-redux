#!/usr/bin/env bash

SAVED_COLORS_DIR="$HOME/.config/polybar/blocks/saved-colors"
CURRENT_COLORS_FILE="$HOME/.config/polybar/blocks/colors.ini"

mkdir -p "$SAVED_COLORS_DIR"

get_config_name() {
    rofi -dmenu -theme ~/.config/polybar/blocks/scripts/rofi/note-taking.rasi -p "Save current colors as: "
}

save_current_config() {
    config_name=$(get_config_name)

    # If no name was entered, exit
    if [ -z "$config_name" ]; then
        exit 1
    fi

    new_config_file="${SAVED_COLORS_DIR}/${config_name}.ini"

    # Check if the config file already exists
    if [ -f "$new_config_file" ]; then
        notify-send "Color save" "A color config with the name '$config_name' already exists. Exiting..."
        exit 1
    fi

    cp "$CURRENT_COLORS_FILE" "$new_config_file"

    # Verification message
    if [ -f "$new_config_file" ]; then
        notify-send "Saved the current colors config as '${config_name}.ini'"
    else
        notify-send "Failed to save the current colors config."
    fi
}

save_current_config
