#!/bin/sh

declare -A tools
declare -A background_args

tools=(
    ["jrnl"]="cli journal client:o:entry"
    ["search"]="search current dir::alias"
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

background_args=(
    ["wthrr"]="-u f,mph -f d,w"
    ["cbonsai"]="-L 42 --screensaver"
    ["gitui"]="-t macchiato.ron"
)

declare -a tool_order=(
    "jrnl"
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
search_command() {
    fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim
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

selected_tool=$(echo -e "$prompt_list" | gum choose)
tool=$(echo "$selected_tool" | cut -d ' ' -f 1)

args_descriptor=${tools[$tool]#*:}
if [ -n "$args_descriptor" ] && [ "$args_descriptor" != ":" ]; then
    arguments=$(prompt_args "$args_descriptor")
    set -- $arguments
fi

bg_args=${background_args[$tool]}

if [[ ${tools[$tool]} == *":alias"* ]]; then
    ${tool}_command
else
    if [ -n "$bg_args" ]; then
        $tool $bg_args $*
    else
        $tool $*
    fi
fi

