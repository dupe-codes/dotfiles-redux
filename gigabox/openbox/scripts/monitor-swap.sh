#!/bin/bash
# Script to toggle a window between two monitors in a dual-monitor setup.

WINDOW_ID=$(xdotool getactivewindow)
eval $(xdotool getwindowgeometry --shell $WINDOW_ID)

MONITOR1_WIDTH=2560  # Width of DP-1
MONITOR2_WIDTH=2256  # Width of eDP-1

if [ "$X" -lt "$MONITOR1_WIDTH" ]; then
  NEW_X=$(($X + $MONITOR1_WIDTH + 20))
else
  NEW_X=$(($X - $MONITOR1_WIDTH - 20))
fi

xdotool windowmove $WINDOW_ID $NEW_X $Y
