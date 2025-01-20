#!/usr/bin/env bash

# TODO: get this working for ad hoc creation of reminders

MSG="$(rofi -dmenu -p "Reminder text?")"
[ -z "$MSG" ] && exit

WHEN="$(rofi -dmenu -p "When? (Remind syntax)")"
[ -z "$WHEN" ] && exit

mkdir -p "${HOME}/.local/share/remind"
echo "REM $WHEN MSG \"$MSG\"" >>"${HOME}/.local/share/remind/reminders.rem"
notify-send "Reminder added" "REM $WHEN MSG \"$MSG\""
