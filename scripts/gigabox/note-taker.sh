#!/usr/bin/bash

source "$HOME"/scripts/constants.sh

NOTES_FILE="$DATASTORE_DIR/configs/note-taker.yaml"
FILE_SELECT_THEME="$GB_SCRIPTS_DIR/rofi/utilscripts.rasi"
NOTE_TEXT_THEME="$GB_SCRIPTS_DIR/rofi/note-taking.rasi"

# Grab note paths and target section header
# The YAML looks something like:
#
# notes:
#   - path: notes/ProjectX.md
#     heading: "### Quick Ideas"
#
# Each path should be relative to $DATASTORE_DIR

mapfile -t PATHS < <(yq -r '.notes[].path' "$NOTES_FILE")
mapfile -t HEADINGS < <(yq -r '.notes[].heading' "$NOTES_FILE")

menu_entries=()
for i in "${!PATHS[@]}"; do
    filename="$(basename "${PATHS[$i]}")"
    menu_entries+=("$i) $filename")
done

selected_entry=$(printf '%s\n' "${menu_entries[@]}" |
    rofi -dmenu -theme "$FILE_SELECT_THEME" -p "Select note target:")

[ -z "$selected_entry" ] && exit 0

selected_index=$(awk -F')' '{print $1}' <<<"$selected_entry")
selected_path="${PATHS[$selected_index]}"
selected_heading="${HEADINGS[$selected_index]}"

INPUT_TEXT=$(rofi -dmenu -theme "$NOTE_TEXT_THEME" -p "Enter note text:")
if [ -z "$INPUT_TEXT" ]; then
    exit 0
fi

selected_path="$DATASTORE_DIR/$selected_path"

if [ ! -f "$selected_path" ]; then
    notify-send "Note-taking Error" "File does not exist: $selected_path"
    exit 1
fi

if grep -Fxq "$selected_heading" "$selected_path"; then
    awk -v section="$selected_heading" -v text="- $INPUT_TEXT" -v ORS="" '
    {
        print $0 "\n";
        if ($0 == section) {
            getline;
            if ($0 != "") {
                print "\n"; # Ensure there is a blank line
            }
            print $0 "\n" text "\n";
            next;
        }
    }' "$selected_path" >"$selected_path.tmp" && mv "$selected_path.tmp" "$selected_path"
else
    echo -e "\n$selected_heading\n\n- $INPUT_TEXT" >>"$selected_path"
fi

notify-send "Note-taking" "Note added to $(basename "$selected_path")"
