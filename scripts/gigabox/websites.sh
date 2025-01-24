#!/bin/bash

# TODO: Migrate this to a website-bookmarks.txt file
#       And add a "save bookmark" rofi script which
#       asks for the bookmark name and url, then adds it
#       to the file
declare -A SITES
SITES=(
    [" TLDraw"]="https://tldraw.com"
    [" Drawing (local)"]="http://localhost:9876/draw"
    [" graphite"]="https://app.graphite.dev"
    ["󰚩 ChatGPT"]="https://chat.openai.com"
    [" Twitch"]="https://www.twitch.tv"
    [" Nerdfonts"]="https://www.nerdfonts.com/cheat-sheet"
    ["󰗃 YouTube"]="https://www.youtube.com"
    [" imissmycafe"]="https://imissmycafe.com"
    [" Notion Calendar"]="https://calendar.notion.so/"
    [" wheeldecide"]="https://wheeldecide.com"
    [" Dropbox"]="https://www.dropbox.com/home"
    [" FFI"]="https://www.formfromimagination.com/products/form-from-imagination"
    [" Google"]="https://www.google.com"
    ["󰇮 Fastmail (email)"]="https://app.fastmail.com/mail/Inbox"
    [" Github"]="https://github.com"
    [" gamedev.tv"]="https://www.gamedev.tv/dashboard/"
    ["󰈙 devdocs"]="https://devdocs.io"
    [" Proko"]="https://www.proko.com/classroom/dashboard"
)

dir="$HOME/scripts/gigabox/rofi"
site_keys=$(printf '%s\n' "${!SITES[@]}")
selected_site=$(echo -e "$site_keys" | rofi -theme "$dir"/utilscripts.rasi -i -dmenu -p "Choose a site:")

if [ -z "$selected_site" ]; then
    echo "No selection made. Exiting."
    exit 1
fi

vivaldi-stable --new-window "${SITES[$selected_site]}"
