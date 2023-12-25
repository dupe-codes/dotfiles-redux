#!/bin/bash

schedules_dir="$HOME/projects/dotfiles-redux/gigacli/scripts/schedules"
quotes_dir="$HOME/datastore/quotes"

weather_icons=(
    ["Overcast"]="󰖐"
    # TODO: Add more weather icons
)

get_weather_icon() {
    local condition="$1"
    if [[ ${weather_icons[$condition]} ]]; then
        echo "${weather_icons[$condition]}"
    else
        echo ""
    fi
}

display_intro() {
    date=$(date "+%A, %B %d, %Y")
    weather=$(gum spin --show-output --spinner line --title "Loading ..." -- \
        curl -s wttr.in/?format="%C")
    weather_icon=$(get_weather_icon "$weather")
    quote_file=$(find $quotes_dir -type f | shuf -n 1)
    quote=$(cat "$quote_file")
    intro_message=" Today is $date.\n\n$weather_icon It's currently $weather.\n\n$quote"
    echo -e "$intro_message" | gum style --border double --align center \
        --width 50 --border-foreground "#7dcfff" --padding "1"
}

get_todays_schedule() {
    day=$(date +%A | tr '[:upper:]' '[:lower:]')
    if [[ -f "$schedules_dir/${day}.csv" ]]; then
        cat "$schedules_dir/${day}.csv"
    else
        echo "No schedule found for today."
    fi
}

display_schedule() {
    todays_schedule=$(get_todays_schedule)
    if [[ $todays_schedule != "No schedule found for today." ]]; then
        echo "$todays_schedule" | gum table -w 10,50 --selected.foreground "#9ece6a" \
            --header.foreground "#9d7cd8" \
            | cut -d ',' -f 1,2
    else
        echo $todays_schedule
    fi
}

display_intro
echo ""
display_schedule
