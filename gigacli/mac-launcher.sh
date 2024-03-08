#!/bin/zsh

# Version of the cli launcher that works on macOS
#
# The original version is incompatible because macOS's verson
# of bash does not support associative arrays.

typeset -A tools
typeset -A background_args
typeset -A tool_aliases

tools=(
    jrnl "󱓧 write a journal entry:o:entry"
    timew " track time:r:start/stop,r:tags"
    task " launch work session:"
    log-task " log past task:"
    timer "󱎫 run timer script:r:tags"
    break " take a break:r:short/long?"
    schedule "󰃭 display today's schedule"
    commit " (conventionally) commit changes"
    search "󰥨 search current dir:"
    ncmpcpp " run music player:"
    ranger " navigate filesystem:"
    cbonsai "󰟀 run screensaver:"
    btm "󰕮 check activity monitor:"
    nap " open snippets manager:"
    nom " open rss feed reader:"
    yt "󰗃 launch youtube client:"
    wthrr "󰖐 check weather:"
    glow " open markdown reader:"
    dust " check disk space:"
    gitui " open git interface:"
    bat "󰊪 read file:r:filename"
)

background_args=(
    wthrr "-u f,mph -f d,w"
    cbonsai "-L 42 --screensaver"
    gitui "-t macchiato.ron"
)

tool_aliases=(
    search "search_command"
    task "task_command"
    log-task "log_task"
    timer "timer_command"
    break "break_command"
    schedule "schedule_command"
    commit "commit_command"
)

tool_order=(
    jrnl
    timew
    timer
    task
    log-task
    break
    schedule
    commit
    search
    ncmpcpp
    ranger
    cbonsai
    btm
    nap
    nom
    yt
    wthrr
    glow
    dust
    gitui
    bat
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
        osascript -e 'display notification "Completed task: '"$tags"'" with title "󰁫 Timer"' & \
        afplay ~/sounds/positive-notification.wav &
}


log_task() {
    tags_list=()
    while IFS= read -r line; do
        tags_list+=("$line")
    done < <(timew tags | awk 'NR > 3 {print $1}')

    tag=$(gum filter --placeholder "Choose a tag finished task..." --no-strict "${tags_list[@]}")
    start_time=$(gum input --placeholder "Enter start datetime (e.g., 2024-03-01T10:00)")
    end_time=$(gum input --placeholder "Enter end datetime (e.g., 2024-03-01T11:00)")

    timew track "$tag" from "$start_time" to "$end_time"
    osascript -e \
        'display notification "Logged past task: '"$tag"' from '"$start_time"' to '"$end_time"'" with title "Timewarrior"'

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
        osascript -e "display notification \"Break is over\" with title \"󰁫 Timer\"" & \
        afplay ~/sounds/positive-notification.wav &
}

prompt_args() {
    local args_list="$1"
    local tool="$2"
    local args=()
    IFS=',' read -rA args_descriptor <<< "$args_list" # Updated to Zsh syntax

    for descriptor in "${args_descriptor[@]}"; do
        local prefix=${descriptor[1,2]}
        local arg_name=${descriptor[3,-1]}

        if [[ "$prefix" == "r:" ]]; then
            args+=("$(gum input --placeholder "$tool: $arg_name")")
        elif [[ "$prefix" == "o:" ]]; then
            vared -p "$tool: (optional) $arg_name? " -c arg_value
            [[ -n "$arg_value" ]] && args+=("$arg_value")
        fi
    done

    echo "${args[@]}"
}

max_length=0
for tool in "${(@k)tools}"; do
    current_length=${#tool}
    if (( current_length > max_length )); then
        max_length=$current_length
    fi
done

prompt_list=""
for tool in "${tool_order[@]}"; do
    full_description=${tools[$tool]}
    description=${full_description%%:*} # Extract description up to the first colon

    # Calculate the padding needed for alignment
    current_length=${#tool}
    let padding=$max_length-current_length
    pad=$(printf "%${padding}s")

    line="$tool$pad      $description\n"  # Additional spaces for clearer separation
    prompt_list+="$line"
done

selected_tool=$(echo -e "$prompt_list" | gum filter --height 20)
tool=$(echo "$selected_tool" | awk '{print $1}')

if [[ -z "$tool" ]]; then
    echo "No tool selected, exiting."
    return 0
fi

args_descriptor=${tools[$tool]#*:}
arguments=""
if [[ -n "$args_descriptor" ]] && [[ "$args_descriptor" != ":" ]]; then
    arguments=$(prompt_args "$args_descriptor" "$tool")
    set -- $arguments
fi
bg_args=${background_args[$tool]}

if [[ -n ${tool_aliases[$tool]} ]]; then
    command_to_run=${tool_aliases[$tool]}
    $command_to_run "$@"
else
    if [[ -n "$bg_args" ]]; then
        $tool $bg_args "$@"
    else
        $tool ${=arguments}
    fi
fi

