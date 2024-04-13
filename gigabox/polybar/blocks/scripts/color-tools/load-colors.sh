#!/usr/bin/env bash

SAVED_COLORS_DIR="$HOME/.config/polybar/blocks/saved-colors"
CURRENT_COLORS_FILE="$HOME/.config/polybar/blocks/colors.ini"

CACHE_DIR="$HOME/.cache/$(whoami)/color-previews"
if [ ! -d "$CACHE_DIR" ]; then
    mkdir -p "$CACHE_DIR"
fi

generate_color_swatches() {
    for config_file in "$SAVED_COLORS_DIR"/*; do
        config_name=$(basename "$config_file")
        preview_path="${CACHE_DIR}/${config_name%.ini}.png"

        if [ ! -f "$preview_path" ]; then
            convert_command="convert -size 400x20 "

            declare -A seen_colors

            # extract colors and append to the image generation command
            while IFS=' =' read -r key value; do
                if [[ "$key" =~ ^(red|pink|purple|blue|cyan|teal|green|lime|yellow|amber|orange|brown|gray|indigo|blue-gray)$ ]]; then
                    color=$(echo "$value" | tr -d ' ')
                    if [ -z "${seen_colors[$color]}" ]; then
                        convert_command+=" xc:${color}"
                        seen_colors[$color]=1
                    fi
                fi
            done < "$config_file"

            convert_command+=" -append -bordercolor black -border 1x1 ${preview_path}"
            eval $convert_command
            unset seen_colors
        fi
    done
}

load_saved_config() {

    monitor_res=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f1)
    monitor_scale=$(xdpyinfo | awk '/resolution/{print $2}' | cut -d 'x' -f1)
    monitor_res=$(( monitor_res * 17 / monitor_scale ))
    rofi_override="element-icon{size:${monitor_res}px;border-radius:0px;}"

    config_files=("$SAVED_COLORS_DIR"/*)
    rofi_list=""
    for config in "${config_files[@]}"; do
        config_name=$(basename "$config")
        if [ -f "${CACHE_DIR}/${config_name%.ini}.png" ]; then
            rofi_list+="${config_name}\x00icon\x1f${CACHE_DIR}/${config_name%.ini}.png\n"
        fi
    done

    dir="~/.config/polybar/blocks/scripts/rofi"
    rofi_command="rofi -no-config -theme $dir/file-preview.rasi"
    selection=$(echo -e "$rofi_list" | $rofi_command -dmenu -i -p "Select color config" -theme-str "$rofi_override")

    #config_name=$(ls "$SAVED_COLORS_DIR" | $rofi_command -i -dmenu -p "Select a saved colors config: ")

    if [ -z "$selection" ]; then
        exit 1
    fi

    selected_config_file="${SAVED_COLORS_DIR}/${selection}"

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

generate_color_swatches
load_saved_config
