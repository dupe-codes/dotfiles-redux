#!/bin/sh

declare -A tools
declare -A background_args

tools=(
    ["jrnl"]="󱓧 write a journal entry:o:entry"
    ["timew"]=" track time:r:start/stop,r:tags"
    ["task"]=" launch work session:"
    ["log-task"]=" log past task:"
    ["timer"]="󱎫 run timer script:r:tags"
    ["break"]=" take a break:r:short/long?"
    ["schedule"]="󰃭 display today's schedule"
    ["commit"]=" (conventionally) commit changes"
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
    "log-task"
    "break"
    "schedule"
    "commit"
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
    ["log-task"]="log_task"
    ["timer"]="timer_command"
    ["break"]="break_command"
    ["schedule"]="schedule_command"
    ["commit"]="commit_command"
    # add other aliases as needed
)

commit_command() {
    $HOME/scripts/commit.sh
}

schedule_command() {
    $HOME/scripts/schedule.sh
}

search_command() {
    fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim
}

task_command() {
    tags_list=()
    while IFS= read -r line; do
        tags_list+=("$line")
    done < <(timew tags | awk 'NR > 3 {print $1}')
    durations=("25m" "30m" "45m" "1hr")

    tag=$(gum filter --placeholder "Choose a tag..." --no-strict "${tags_list[@]}")
    duration=$(gum filter --placeholder "Choose a duration..." --no-strict "${durations[@]}")

    timew start $tag; \
        termdown $duration; \
        timew stop; \
        notify-send "󰁫 Timer" "Completed task: $tags"; \
        paplay ~/sounds/positive-notification.wav &
}

log_task() {
    tags_list=()
    while IFS= read -r line; do
        tags_list+=("$line")
    done < <(timew tags | awk 'NR > 3 {print $1}')

    today=$(date "+%Y-%m-%d")
    tag=$(gum filter --placeholder "Choose a tag finished task..." --no-strict "${tags_list[@]}")
    start_time=$(gum input --prompt "Start time: " --value "${today}T")
    end_time=$(gum input --prompt "End time: " --value "${today}T")

    timew track "$tag" from "$start_time" to "$end_time"
    notify-send "Timewarrior" "Logged past task: $tag from $start_time to $end_time"
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

selected_tool=$(echo -e "$prompt_list" | gum filter --height 25)
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

