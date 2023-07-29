#!/usr/bin/env bash

REDSHIFT_RUNNING=$(pgrep -x redshift)

if [ -z "$REDSHIFT_RUNNING" ]; then
    redshift -P &
    notify-send "Redshift" "Started!"
    exit 0
fi

#redshift -x
pkill -USR1 '^redshift$'

REDSHIFT_ON =$(
    xrandr --verbose |
    awk -F: '
        /Gamma/ {
            if ( $2 + $3 + $4 != 3.0 ) {
                print "true";
            } else {
                print "false";
            }
        }
    '
)
if [ "$REDSHIFT_ON" = "true"]; then
    notify-send "Redshift" "Toggled on "
else
    notify-send "Redshift" "Toggled off "
fi

