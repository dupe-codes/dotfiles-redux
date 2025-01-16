#!/bin/bash

TODO_FILE="$HOME/datastore/TODO.md"
SECTION_HEADING="## inbox"

if [ ! -f "$TODO_FILE" ]; then
    notify-send "TODO Error" \
        "The '$TODO_FILE' note does not yet exist."
    exit 1
fi

INPUT_TEXT=$(rofi -dmenu \
    -theme "$HOME/scripts/gigabox/rofi/note-taking.rasi" \
    -p "Enter TODO:")
if [ -z "$INPUT_TEXT" ]; then
    exit 0
fi

if grep -q "$SECTION_HEADING" "$TODO_FILE"; then
    awk -v section="$SECTION_HEADING" -v text="- [ ] $INPUT_TEXT" -v ORS="" '
    {
        print $0 "\n";
        if ($0 == section) {
            getline;
            if ($0 != "") {
                print "\n"; # Ensure there is a blank line after heading
            }
            print $0 "\n" text "\n";
            next; # Skip further processing of this line
        }
    }' "$TODO_FILE" >"$TODO_FILE.tmp" && mv "$TODO_FILE.tmp" "$TODO_FILE"
else
    echo -e "\n$SECTION_HEADING\n\n- $INPUT_TEXT" >>"$TODO_FILE"
fi

notify-send "TODO added" "Added to '$TODO_FILE'."
