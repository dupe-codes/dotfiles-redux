#!/bin/bash

NOTES_DIR="$HOME/datastore/daily notes"
TODAYS_NOTE="$(date +%F).md"
NOTE_PATH="$NOTES_DIR/$TODAYS_NOTE"

if [ ! -f "$NOTE_PATH" ]; then
    notify-send "Note-taking Error" "Today's daily note does not yet exist."
    exit 1
fi

INPUT_TEXT=$(rofi -dmenu -theme ~/.config/polybar/blocks/scripts/rofi/note-taking.rasi -p "Enter note text:")
if [ -z "$INPUT_TEXT" ]; then
    exit 0
fi

echo -e "- $INPUT_TEXT" >> "$NOTE_PATH"
notify-send "Note-taking" "Note added to $TODAYS_NOTE"
