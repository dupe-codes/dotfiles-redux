#!/bin/bash

schedules_dir="$HOME/datastore/scheduling/schedules"
quotes_dir="$HOME/datastore/scheduling/quotes"
activities_dir="$HOME/datastore/scheduling/activities"

weather_icons=(
    ["Overcast"]="󰖐"
    ["Light_rain"]="󰖗"
    # TODO: Add more weather icons
)

get_weather_icon() {
    local condition="${1// /_}" # replace spaces with underscores
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
    intro_message=" Today is $date\n\n$weather_icon Current weather: $weather\n\n$quote"
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
        selected_row=$(\
            echo "$todays_schedule" \
            | gum table -w 10,50 --selected.foreground "#9ece6a" \
            --header.foreground "#9d7cd8" \
            | cut -d ',' -f 1,2 \
            | xargs)
        if [ ! -z "$selected_row" ]; then
            selected_activity=$(echo "$selected_row" \
                | cut -d ',' -f 2 \
                | awk '{$1=$1};1' \
                | tr '[:upper:]' '[:lower:]')
            filename=$(echo "$selected_activity" | tr ' ' '_' | tr -d '\n').md
            if [[ -f "$activities_dir/$filename" ]]; then
                glow -p "$activities_dir/$filename"
            else
                echo "No additional information available for $selected_activity."
            fi
        fi
    else
        echo $todays_schedule
    fi
}

display_intro
echo ""
display_schedule
