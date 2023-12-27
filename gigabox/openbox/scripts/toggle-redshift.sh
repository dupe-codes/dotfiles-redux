#!/usr/bin/env bash

toggle_redshift() {
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
}

REDSHIFT_RUNNING=$(pgrep -x redshift)

if [[ "$1" == "--snooze" ]]; then
    if [ -z "$REDSHIFT_RUNNING" ]; then
        notify-send "Redshift" "Redshift is not running"
        exit 0
    fi
    pkill -USR1 '^redshift$'
    notify-send "Redshift" "Snoozed for 1 hour"
    # TODO: Clean up path once gigabox + gigacli scripts are consolidated
    #       and properly linked to ~/scripts
    echo "~/projects/dotfiles-redux/gigabox/openbox/scripts/toggle-redshift.sh" \
        | at now +1 hours
    exit 0
fi


if [ -z "$REDSHIFT_RUNNING" ]; then
    redshift -P &
    notify-send "Redshift" "Started!"
    exit 0
fi

toggle_redshift

