#!/bin/bash

# TODO: Migrate this to a website-bookmarks.txt file
#       And add a "save bookmark" rofi script which
#       asks for the bookmark name and url, then adds it
#       to the file
declare -A SITES
SITES=(
    [" Old Reader: RSS Feeds"]="https://theoldreader.com"
    ["󱚌 Google Scholar"]="https://scholar.google.com"
    ["󰌢 Arxiv"]="https://arxiv.org"
    ["󰚩 ChatGPT"]="https://chat.openai.com"
    [" Twitch"]="https://www.twitch.tv"
    [" Nerdfonts"]="https://www.nerdfonts.com/cheat-sheet"
    ["󰗃 YouTube"]="https://www.youtube.com"
    [" imissmycafe"]="https://imissmycafe.com"
    [" HuggingFace Papers"]="https://huggingface.co/papers"
)

dir="~/.config/polybar/blocks/scripts/rofi"
site_keys=$(printf '%s\n' "${!SITES[@]}")
selected_site=$(echo -e "$site_keys" | rofi -theme $dir/utilscripts.rasi -i -dmenu -p "Choose a site:")

if [ -z "$selected_site" ]; then
    echo "No selection made. Exiting."
    exit 1
fi

vivaldi-stable --new-window "${SITES[$selected_site]}"

