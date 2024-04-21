#!/bin/bash

source $HOME/secrets.sh
API_URL="https://api.openai.com/v1/chat/completions"

CONVO_FILE="/tmp/gpt_convo.txt"
if [ ! -f "$CONVO_FILE" ]; then
    echo '[]' > "$CONVO_FILE"
fi

# Define associative array of available roles for GPT to take on
# Each entry is a role title mapped to the system prompt to send to GPT to assume
declare -A roles

roles["math tutor"]="You are a math tutor who helps students of all levels understand \
and solve mathematical problems. Provide step-by-step explanations and guidance for \
a range of topics, from basic arithmetic to advanced calculus. Use clear language \
and visual aids to make complex concepts easier to grasp."

roles["engineer"]="You are an experienced software engineer and a collaborative \
pairing partner. You have extensive knowledge in a variety of programming languages \
and technologies, including but not limited to Python, Java, JavaScript, C++, SQL, and \
web development frameworks. You are skilled in writing clean, efficient, and bug-free \
code. You are also proficient in debugging, problem-solving, and optimizing code for \
performance. You are familiar with software development methodologies like Agile and \
DevOps practices. Your role is to assist with coding tasks, review code, suggest \
improvements, offer insights on best practices, and answer technical questions. \
You aim to help in creating high-quality software products by providing expert advice \
and practical solutions."

roles["machine learning"]="You are a Machine Learning Tutor AI, dedicated to guiding \
senior software engineers in their journey to become proficient machine learning \
engineers. Provide comprehensive information on machine learning concepts, techniques, \
and best practices. Offer step-by-step guidance on implementing machine learning \
algorithms, selecting appropriate tools and frameworks, and building end-to-end \
machine learning projects. Tailor your instructions and resources to the individual \
needs and goals of the user, ensuring a smooth transition into the field of \
machine learning."

send_query() {
    local messages=$(cat "$CONVO_FILE")
    local data=$(jq -n \
                    --argjson messages "$messages" \
                    '{"model": "gpt-4", "messages": $messages}')

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
    CURRENT_PROMPT=$(jq -r '[.[] | select(.role == "system")][-1].content // "None" | split(": ")[1]' "$CONVO_FILE")
    ROLE_HEADER="Current role prompt: $CURRENT_PROMPT"

    break_long_line() {
        local line=$1
        local max_length=100
        while [ ${#line} -gt $max_length ]; do
            echo "${line:0:$max_length}"
            line="${line:$max_length}"
        done
        echo "$line"
    }

    break_long_line "$ROLE_HEADER"

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
    | sed 's/USER:/\n-----------------------\nYou:/g' \
    | sed 's/ASSISTANT:/\n-----------------------\nGPT:/g'
}

save_conversation() {
    CURRENT_PROMPT=$(jq -r '[.[] | select(.role == "system")][-1].content // "None" | split(": ")[1]' "$CONVO_FILE")
    ROLE_HEADER="Current role prompt: $CURRENT_PROMPT"
    echo "$ROLE_HEADER"

    jq -r '.[] | select(.role != "system") | "\(.role | ascii_upcase): \(.content)"' "$CONVO_FILE" \
    | sed 's/USER:/\n-----------------------\nYou:/g' \
    | sed 's/ASSISTANT:/\n-----------------------\nGPT:/g'
}

dir="$HOME/scripts/gigabox/rofi"

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
        save_conversation > "$SAVE_FILE"
        notify-send "ChatGPT" "Conversation saved to $SAVE_FILE"
        continue
    fi

    if [[ "$USER_QUERY" =~ ^\\role\ (.+) ]]; then
        ROLE_SELECTION="${BASH_REMATCH[1]}"
        if [[ -n "${roles[$ROLE_SELECTION]}" ]]; then
            jq --arg role_msg "system: ${roles[$ROLE_SELECTION]}" \
               '. = [{"role": "system", "content": $role_msg}] + .' \
               "$CONVO_FILE" > temp && mv temp "$CONVO_FILE"

            notify-send "GPT Convo" "Role changed to $ROLE_SELECTION"
        else
            notify-send "GPT Convo" "Role $ROLE_SELECTION does not exist."
        fi
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
