#!/bin/bash

# Read the contents of keybinds.txt into an array, splitting by line
IFS=$'\n' read -d '' -r -a lines < $HOME/projects/dotfiles-redux/gigabox/keybinds.txt

# Find the maximum length of the descriptions
max_length=0
for line in "${lines[@]}"; do
    description=$(echo $line | cut -d';' -f1)
    length=${#description}
    if (( length > max_length )); then
        max_length=$length
    fi
done

formatted=""
for line in "${lines[@]}"; do
    description=$(echo $line | cut -d';' -f1)
    keybind=$(echo $line | cut -d';' -f2)
    padded_description=$(printf "%-${max_length}s" "$description")
    formatted+="$padded_description => $keybind\n"
done

dir="~/.config/polybar/blocks/scripts/rofi"
echo $formatted
echo -e "$formatted" | \
    rofi -no-config \
    -theme $dir/keybinds.rasi \
    -p "gigabox keybinds" \
    -dmenu \
