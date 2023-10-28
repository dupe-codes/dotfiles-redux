#!/bin/sh

declare -A tools
declare -A background_args

tools=(
    ["jrnl"]="cli journal client:o:entry"
    ["timew"]="time tracker:r:start/stop,r:tags"
    ["task"]="launch work session:r:tags,r:duration"
    ["search"]="search current dir:"
    ["ncmpcpp"]="music player client:"
    ["ranger"]="file manager:"
    ["cbonsai"]="screensaver:"
    ["btm"]="activity monitor:"
    ["nap"]="snippets manager:"
    ["nom"]="RSS feed reader:"
    ["yt"]="cli youtube client:"
    ["wthrr"]="weather app:"
    ["glow"]="markdown reader:"
    ["dust"]="disk space visualizer:"
    ["gitui"]="visual git interface:"
    ["bat"]="better cat:r:filename"
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
    "task"
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
    # add other aliases as needed
)

search_command() {
    fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim
}

task_command() {
    local tags=$1
    local duration=$2
    timew start $tags; \
        termdown $duration && timew stop; \
        notify-send "󰁫 Timer" "Completed task: $tags"; \
        paplay ~/sounds/positive-notification.wav &
}

prompt_args() {
    local args_list="$1"
    local args=()
    IFS=',' read -ra args_descriptor <<< "$args_list"

    for descriptor in "${args_descriptor[@]}"; do
        local prefix=${descriptor:0:2}
        local arg_name=${descriptor:2}

        if [ "$prefix" = "r:" ]; then
            args+=("$(gum input --placeholder "$arg_name")")
        elif [ "$prefix" = "o:" ]; then
            read -p "(optional) $arg_name? " arg_value
            [ -n "$arg_value" ] && args+=("$arg_value")
        fi
    done

    echo "${args[@]}"
}

prompt_list=""
for tool in "${tool_order[@]}"; do
    IFS=':' read -r description args <<< "${tools[$tool]}"
    prompt_list+="$tool"
    [ -n "$description" ] && prompt_list+=" ($description)"
    prompt_list+="\n"
done

selected_tool=$(echo -e "$prompt_list" | gum choose --height 20)
tool=$(echo "$selected_tool" | cut -d ' ' -f 1)

if [ -z "$tool" ]; then
    echo "No tool selected, exiting."
    exit 0
fi

args_descriptor=${tools[$tool]#*:}
if [ -n "$args_descriptor" ] && [ "$args_descriptor" != ":" ]; then
    arguments=$(prompt_args "$args_descriptor")
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

