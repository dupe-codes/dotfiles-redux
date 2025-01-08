#!/bin/bash

timew start "$@"
echo ''

start_time=$(date +%s)

gum spin --title "Time tracking 󰄉" --show-output --spinner dot -- sh -c '
echo ""
while true; do
    elapsed=$(($(date +%s) - '"$start_time"'))
    printf "\n%02d:%02d:%02d" $((elapsed / 3600)) $(((elapsed / 60) % 60)) $((elapsed % 60))
    sleep 60
done
'

echo ''
timew stop
notify-send "󰁫 Timer" "Completed timer"
paplay ~/sounds/positive-notification.wav &
