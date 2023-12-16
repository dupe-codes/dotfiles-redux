#!/bin/sh

declare -A tools
declare -A background_args

tools=(
    ["jrnl"]="󱓧 write a journal entry:o:entry"
    ["timew"]=" track time:r:start/stop,r:tags"
    ["task"]=" launch work session:r:tags,r:duration"
    ["timer"]="󱎫 run timer script:r:tags"
    ["break"]=" take a break:r:short/long?"
    ["search"]="󰥨 search current dir:"
    ["ncmpcpp"]=" run music player:"
    ["ranger"]=" navigate filesystem:"
    ["cbonsai"]="󰟀 run screensaver:"
    ["btm"]="󰕮 check activity monitor:"
    ["nap"]=" open snippets manager:"
    ["nom"]=" open rss feed reader:"
    ["yt"]="󰗃 launch youtube client:"
    ["wthrr"]="󰖐 check weather:"
    ["glow"]=" open markdown reader:"
    ["dust"]=" check disk space:"
    ["gitui"]=" open git interface:"
    ["bat"]="󰊪 read file:r:filename"
)

# NOTE: Alias tools do not currently support background args
background_args=(
    ["wthrr"]="-u f,mph -f d,w"
    ["cbonsai"]="-L 42 --screensaver"
    ["gitui"]="-t macchiato.ron"
)

declare -a tool_order=(
    "jrnl"
    "timew"
    "timer"
    "task"
    "break"
    "search"
    "ncmpcpp"
    "ranger"
    "cbonsai"
    "btm"
    "nap"
    "nom"
    "yt"
    "wthrr"
    "glow"
    "dust"
    "gitui"
    "bat"
)

# Support aliases and more complicated tool queries via *_command functions
declare -A aliases=(
    ["search"]="search_command"
    ["task"]="task_command"
    ["timer"]="timer_command"
    ["break"]="break_command"
    # add other aliases as needed
)

search_command() {
    fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim
}


# TODO: when inputting task arguments (tags, duration), include list of
#       options to choose from
#       Get list of existings tags from timew tags
#       Have standard durations like 25m, 30m, 45m, 1hr
task_command() {
    local tags=$1
    local duration=$2
    timew start $tags; \
        termdown $duration; \
        timew stop; \
        notify-send "󰁫 Timer" "Completed task: $tags"; \
        paplay ~/sounds/positive-notification.wav &
}

timer_command() {
    local tags=$1
    ~/scripts/timer.sh $tags
}

break_command() {
    local break_type=$1
    # accept "short" or "s"
    if [ "$break_type" = "short" ] || [ "$break_type" = "s" ]; then
        local duration="5m"
    else
        local duration="15m"
    fi
    termdown $duration && \
        notify-send "󰁫 Timer" "Break is over"; \
        paplay ~/sounds/positive-notification.wav &
}

prompt_args() {
    local args_list="$1"
    local tool="$2"
    local args=()
    IFS=',' read -ra args_descriptor <<< "$args_list"

    for descriptor in "${args_descriptor[@]}"; do
        local prefix=${descriptor:0:2}
        local arg_name=${descriptor:2}

        if [ "$prefix" = "r:" ]; then
            args+=("$(gum input --placeholder "$tool: $arg_name")")
        elif [ "$prefix" = "o:" ]; then
            read -p "$tool: (optional) $arg_name? " arg_value
            [ -n "$arg_value" ] && args+=("$arg_value")
        fi
    done

    echo "${args[@]}"
}

# Find the maximum length of tool names for alignment
max_length=0
for tool in "${!tools[@]}"; do
    current_length=${#tool}
    if (( current_length > max_length )); then
        max_length=$current_length
    fi
done

prompt_list=""
for tool in "${tool_order[@]}"; do
    IFS=':' read -r description args <<< "${tools[$tool]}"

   # Calculate the padding needed for alignment
    current_length=${#tool}
    let padding=$max_length-$current_length
    pad=$(printf "%${padding}s")

    line="$tool$pad      $description\n"  # Additional spaces for clearer separation
    prompt_list+="$line"
done

selected_tool=$(echo -e "$prompt_list" | gum filter --height 20)
tool=$(echo "$selected_tool" | cut -d ' ' -f 1)

if [ -z "$tool" ]; then
    echo "No tool selected, exiting."
    exit 0
fi

args_descriptor=${tools[$tool]#*:}
if [ -n "$args_descriptor" ] && [ "$args_descriptor" != ":" ]; then
    arguments=$(prompt_args "$args_descriptor" "$tool")
    set -- $arguments
fi
bg_args=${background_args[$tool]}

if [[ -n ${aliases[$tool]} ]]; then
    command_to_run=${aliases[$tool]}
    $command_to_run $*
else
    if [ -n "$bg_args" ]; then
        $tool $bg_args $*
    else
        $tool $*
    fi
fi

