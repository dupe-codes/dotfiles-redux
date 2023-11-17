#!/bin/bash

# GPT API credentials
# TODO: Get this key from 1password
API_KEY="KEY HERE"
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
    #echo "$data"

    local response=$(curl -s -X POST "$API_URL" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $API_KEY" \
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
    | sed 's/USER:/You:/g' \
    | sed 's/ASSISTANT:/GPT:/g'
}

# TODO: This is a big WIP. Need to fix how long responses/messages are displayed
while true; do
    USER_QUERY=$(format_conversation | rofi -dmenu -p "Your query: ")
    [ $? -ne 0 ] && break

    if [ "$USER_QUERY" == "/clear" ]; then
        echo '[]' > "$CONVO_FILE"
        continue
    fi

    jq --arg query "$USER_QUERY" '. += [{"role": "user", "content": $query}]' "$CONVO_FILE" > temp && mv temp "$CONVO_FILE"
    zenity --progress --title="Loading" --text="Waiting on GPT response..." --pulsate --no-cancel &
    GPT_RESPONSE=$(send_query)
    kill $!
    jq --arg response "$GPT_RESPONSE" '. += [{"role": "assistant", "content": $response}]' "$CONVO_FILE" > temp && mv temp "$CONVO_FILE"
done
