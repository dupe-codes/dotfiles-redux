#!/bin/bash

declare -A SITES
SITES=(
    [" Old Reader: RSS Feeds"]="https://theoldreader.com"
)

dir="~/.config/polybar/blocks/scripts/rofi"
site_keys=$(printf '%s\n' "${!SITES[@]}")
selected_site=$(echo -e "$site_keys" | rofi -theme $dir/utilscripts.rasi -dmenu -p "Choose a site:")

if [ -z "$selected_site" ]; then
    echo "No selection made. Exiting."
    exit 1
fi

vivaldi-stable --new-window "${SITES[$selected_site]}"

