#!/usr/bin/env bash

REDSHIFT_RUNNING=$(pgrep -x redshift)

if [ -z "$REDSHIFT_RUNNING" ]; then
    redshift -P &
    notify-send "Redshift" "Started!"
    exit 0
fi

#redshift -x
pkill -USR1 '^redshift$'
sleep 5s

REDSHIFT_ON=$(
    xrandr --verbose |
    awk -F: '
        BEGIN { result="false" }
        /Gamma/ {
            if ( $2 + $3 + $4 != 3.0 ) {
                result="true";
                exit;
            }
        }
        END { print result }
    '
)

if [ "$REDSHIFT_ON" = "true" ]; then
    notify-send "Redshift" "Toggled on "
else
    notify-send "Redshift" "Toggled off "
fi

