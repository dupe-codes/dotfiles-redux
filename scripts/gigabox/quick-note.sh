#!/bin/bash

NOTES_DIR="$HOME/datastore/daily notes"
TODAYS_NOTE="$(date +%F).md"
NOTE_PATH="$NOTES_DIR/$TODAYS_NOTE"
SECTION_HEADING="## 📓 notes"

if [ ! -f "$NOTE_PATH" ]; then
    notify-send "Note-taking Error" "Today's daily note does not yet exist."
    exit 1
fi

INPUT_TEXT=$(rofi -dmenu -theme $HOME/scripts/gigabox/rofi/note-taking.rasi -p "Enter note text:")
if [ -z "$INPUT_TEXT" ]; then
    exit 0
fi

# prepend note to the designated section, ensuring
# a new line after the section heading
if grep -q "$SECTION_HEADING" "$NOTE_PATH"; then
    awk -v section="$SECTION_HEADING" -v text="- $INPUT_TEXT" -v ORS="" '
    {
        print $0 "\n";
        if ($0 == section) {
            getline;
            if ($0 != "") {
                print "\n"; # Ensure there is a blank line
            }
            print $0 "\n" text "\n";
            next; # Skip further processing of this line
        }
    }' "$NOTE_PATH" > "$NOTE_PATH.tmp" && mv "$NOTE_PATH.tmp" "$NOTE_PATH"
else
    echo -e "\n$SECTION_HEADING\n\n- $INPUT_TEXT" >> "$NOTE_PATH"
fi

notify-send "Note-taking" "Note added to $TODAYS_NOTE"
