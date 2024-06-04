#!/bin/bash

timew start "$@"
echo ''
gum spin --spinner dot --title "Time tracking 󰄉" -- sleep 10800
echo ''
timew stop
