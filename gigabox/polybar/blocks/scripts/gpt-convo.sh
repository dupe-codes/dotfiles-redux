#!/bin/bash

source $HOME/secrets.sh
API_URL="https://api.openai.com/v1/chat/completions"

CONVO_FILE="/tmp/gpt_convo.txt"
if [ ! -f "$CONVO_FILE" ]; then
    echo '[]' > "$CONVO_FILE"
fi

send_query() {
    local messages=$(cat "$CONVO_FILE")
    local data=$(jq -n \
                    --argjson messages "$messages" \
                    '{"model": "gpt-3.5-turbo", "messages": $messages}')

    local response=$(curl -s -X POST "$API_URL" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d "$data")

    if echo "$response" | jq -e '.error' > /dev/null; then
        local error_message=$(echo "$response" | jq -r '.error.message')
        echo "Error from GPT (/clear convo): $error_message"f
        return 1
    else
        echo "$response" | jq -r '.choices[0].message.content'
    fi
}

format_conversation() {
    jq -r '.[] | select(.role != "system") | "\(.role | ascii_upcase): \(.content)"' "$CONVO_FILE" \
    | awk '{
        line=$0;
        max_length=100; # Adjust this value as needed
        while(length(line) > max_length) {
            print substr(line, 1, max_length);
            line=substr(line, max_length + 1);
        }
        print line;
    }' \
    | sed 's/USER:/-----------------------\nYou:/g' \
    | sed 's/ASSISTANT:/\-----------------------\nGPT:/g'
}

dir="~/.config/polybar/blocks/scripts/rofi"

# TODO: This is a big WIP. The running list of TODOs...
while true; do
    USER_QUERY=$(format_conversation | rofi -theme $dir/chatgpt.rasi -dmenu -p "󰍦 Message ChatGPT")
    [ $? -ne 0 ] && break

    if [ "$USER_QUERY" == "\clear" ]; then
        echo '[]' > "$CONVO_FILE"
        continue
    fi

    if [ "$USER_QUERY" == "\save" ]; then
        TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")
        UUID=$(uuidgen)
        SAVE_FILE="$HOME/datastore/chatgpt/convo-${TIMESTAMP}-${UUID}.txt"
        format_conversation > "$SAVE_FILE"
        notify-send "ChatGPT" "Conversation saved to $SAVE_FILE"
        continue
    fi

    jq --arg query "$USER_QUERY" \
        '. += [{"role": "user", "content": $query}]' \
        "$CONVO_FILE" > temp && mv temp "$CONVO_FILE"
    zenity \
        --progress \
        --title="Loading" \
        --text="Waiting on GPT response..." \
        --pulsate \
        --no-cancel &
    GPT_RESPONSE=$(send_query)
    kill $!
    jq --arg response "$GPT_RESPONSE" \
        '. += [{"role": "assistant", "content": $response}]' \
        "$CONVO_FILE" > temp && mv temp "$CONVO_FILE"
done
