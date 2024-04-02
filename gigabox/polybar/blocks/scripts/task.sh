#!/bin/bash

QUEST_LOG_DIR="$HOME/datastore"
QUEST_LOG_FILE="00 - quest log & character stats.md"
QUEST_LOG_PATH="$QUEST_LOG_DIR/$QUEST_LOG_FILE"

# Extract sections for rofi input
IGNORE_SECTION=0
SECTIONS=""
while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" == "-- QUEST LOG END --" ]]; then
        IGNORE_SECTION=1
        break
    fi
    if [[ $IGNORE_SECTION -eq 0 && "$line" =~ ^####\  ]]; then
        SECTIONS+="${line:5}\n"
    fi
done < "$QUEST_LOG_PATH"
SECTIONS=$(echo -e "$SECTIONS" | sed '/^\s*$/d')

TYPE=$(echo -e "$SECTIONS" | rofi -dmenu -theme ~/.config/polybar/blocks/scripts/rofi/utilscripts.rasi -p "Enter task type:")
if [ -z "$TYPE" ]; then
    exit 0
fi

TAG=$(rofi -dmenu -theme ~/.config/polybar/blocks/scripts/rofi/note-taking.rasi -p "Enter tag:")
if [ -z "$TAG" ]; then
    exit 0
fi

TASK=$(rofi -dmenu -theme ~/.config/polybar/blocks/scripts/rofi/note-taking.rasi -p "Enter task:")
if [ -z "$TASK" ]; then
    exit 0
fi

FORMATTED_TASK="- [ ] #$TAG $TASK"

if [ ! -f "$QUEST_LOG_PATH" ]; then
    notify-send "Quest Log does not exist. Creating file."
    touch "$QUEST_LOG_PATH"
fi

TEMP_FILE="$QUEST_LOG_PATH.temp"
SECTION_FOUND=0
IGNORE_SECTION=0
PRINTED=0

while IFS= read -r line || [[ -n "$line" ]]; do
    echo "$line" >> "$TEMP_FILE"
    if [[ "$line" == "-- QUEST LOG END --" ]]; then
        IGNORE_SECTION=1
    fi
    if [[ $IGNORE_SECTION -eq 0 && $PRINTED -eq 0 && "$line" =~ ^####\  && "$line" =~ $TYPE && $SECTION_FOUND -eq 0 ]]; then
        SECTION_FOUND=1
    elif [[ $SECTION_FOUND -eq 1 && "$line" == "" ]]; then
        echo "$FORMATTED_TASK" >> "$TEMP_FILE"
        SECTION_FOUND=0
        PRINTED=1
    fi
done < "$QUEST_LOG_PATH"

mv "$TEMP_FILE" "$QUEST_LOG_PATH"

notify-send "Quest Log" "Task added under $TYPE with tag $TAG"
