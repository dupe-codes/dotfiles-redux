#!/bin/bash

if ! pgrep -x "remind" > /dev/null; then
    remind -z60 ~/.config/remind/reminders.rem | while IFS= read -r line
    do
      if [ -n "$line" ]; then
        notify-send "󰙊 Reminder" "$line"
      fi
    done
fi

