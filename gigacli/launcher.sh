#!/bin/sh

# TODO: Figure out how to support aliases defined in your nushell config
#       Maybe just redefine them here, /shrug
#       That's needed for the following tools:\
#       "r"         "ranger file manager"
#       "bonsai"    "sceensaver"
#       "pomodoro"  "pomodoro timer"

tools_descriptions=(
    "nom"       "rss feed reader"
    "yewtube"   "youtube video player"
    "wthrr"     "weather forecasts"
    "glow"      "markdown reader"
    "nap"       "snippets manager"
    "btm"       "activity monitor"
    "dust"      "disk space visualizer"
    "gitui"     "git ui"
    "ncmcpp"    "music player client"
)

prompt_list=""
for (( i=0; i<${#tools_descriptions[@]}; i+=2 )); do
    tool=${tools_descriptions[i]}
    description=${tools_descriptions[i+1]}

    if [ -n "$description" ]; then
        prompt_list+="$tool ($description)\n"
    else
        prompt_list+="$tool\n"
    fi
done

selected_tool=$(echo -e "$prompt_list" | gum choose)
tool=$(echo "$selected_tool" | cut -d ' ' -f 1)
$tool
