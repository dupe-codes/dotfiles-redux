#!/usr/bin/env bash

# TODO: this won't work because the breaktimer cli isn't on PATH for... reasons

enable_breaktimer() {
    breaktimer enable
    notify-send "Breaktimer" "Enabled"
}

disable_breaktimer() {
    local is_snoozed=$1
    breaktimer disable
    if [ "$is_snoozed" = true ]; then
        notify-send "Breaktimer" "Snoozed for 1 hour"
    else
        notify-send "Breaktimer" "Disabled"
    fi
}

breaktimer_running=$(pgrep -x breaktimer)

if [[ "$1" == "--snooze" ]]; then
    if [ -z "$breaktimer_running" ]; then
        notify-send "Breaktimer" "Breaktimer is not running"
        exit 0
    fi
    disable_breaktimer true
    # TODO: Clean up path once gigabox + gigacli scripts are consolidated
    #       and properly linked to ~/scripts
    echo "~/projects/dotfiles-redux/gigabox/openbox/scripts/toggle-breaktimer.sh" |
        at now +1 hours
    exit 0
fi

if [ -z "$breaktimer_running" ]; then
    breaktimer &
    notify-send "Breaktimer" "Started!"
    exit 0
fi

#if [[ $(safeeyes --status) == *"Disabled"* ]]; then
#enable_breaktimer
#else
#disable_breaktimer false
#fi
