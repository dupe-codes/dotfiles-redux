#!/bin/bash

wrap_text() {
    local s=$1
    local w=$2
    local l=0
    local words=($s)

    for word in "${words[@]}"; do
        l=$((l + ${#word} + 1))
        if [ $l -gt $w ]; then
            echo
            l=$((0 + ${#word} + 1))
        fi
        echo -n "$word "
    done
    echo
}

CHEATSHEETS_DIR="$HOME/projects/dotfiles-redux/gigabox/cheatsheets"
DESCRIPTIONS_SECTION="\[descriptions\]"
LINE_BREAK_THRESHOLD=70

dir="$HOME/scripts/gigabox/rofi"
rofi_command="rofi -no-config -theme $dir/utilscripts.rasi"
sheet_name=$(ls "$CHEATSHEETS_DIR" | $rofi_command -dmenu -p "Select a cheatsheet:")

if [ -z "$sheet_name" ]; then
    exit 1
fi

selected_cheatsheet_file="${CHEATSHEETS_DIR}/${sheet_name}"

if [ ! -f "$selected_cheatsheet_file" ]; then
    notify-send "The selected cheatsheet does not exist."
    exit 1
fi

IFS=$'\n' read -d '' -r -a lines < $selected_cheatsheet_file

# Parse out each key and any associated longer descriptions
# Also compute the max length across all keys, for formatting
max_length=0
keybinds=()
descriptions=()
is_description_section=false
for line in "${lines[@]}"; do
    if echo "$line" | grep -q "^$DESCRIPTIONS_SECTION$"; then
        is_description_section=true
        continue
    fi

    if [ "$is_description_section" = false ]; then
        key=$(echo $line | awk -F ':=' '{print $1}')
        length=${#key}
        if (( length > max_length )); then
            max_length=$length
        fi
        keybinds+=("$line")
    else
        descriptions+=("$line")
    fi
done

formatted=""
for line in "${keybinds[@]}"; do
    short_description=$(echo $line | awk -F ':=' '{print $1}')
    keybind=$(echo $line | awk -F ':=' '{print $2}')
    padded_description=$(printf "%-${max_length}s" "$short_description")
    formatted+="$padded_description => $keybind\n"
done


rofi_command="rofi -no-config -theme $dir/keybinds.rasi"
selected_keybind=$(echo -e "$formatted" | $rofi_command -dmenu -p "$sheet_name")

selected_key=$(echo $selected_keybind | awk -F '=>' '{print $1}' | xargs)
for line in "${descriptions[@]}"; do
    key=$(echo $line | awk -F ':=' '{print $1}' | xargs)
    if [[ $selected_key == "$key" ]]; then
        description=$(echo $line | awk -F ':=' '{print $2}')
        wrapped_description=$(wrap_text "$description" $LINE_BREAK_THRESHOLD)
        echo -e "$wrapped_description" | $rofi_command -theme $dir/keybinds.rasi -dmenu -p "$key"
        break
    fi
done
