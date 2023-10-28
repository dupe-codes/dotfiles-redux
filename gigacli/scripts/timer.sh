#!/bin/bash

timew start "$@";
echo ''
gum spin --spinner dot --title "Time tracking 󰄉" -- sleep 100000
echo ''
timew stop
