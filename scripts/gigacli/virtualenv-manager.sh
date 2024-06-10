#!/bin/zsh

ENV_DIR="$HOME/environments"

create_env() {
    local version=$(gum input --placeholder "python version" --value "3.10")
    local name=$(gum input --placeholder "env name")
    mkdir -p "$ENV_DIR"
    virtualenv -p python$version "$ENV_DIR/$name"
    echo "environment $name created using python $version"
}

list_envs() {
    if [ -d "$ENV_DIR" ] && [ "$(ls -A $ENV_DIR)" ]; then
        local cmd_args="-- \"# environments\""
        for env in $(ls "$ENV_DIR"); do
            cmd_args+=" \"- $env\""
        done
        eval "gum format $cmd_args"
    else
        echo "no environments directory found" | gum format
    fi
}

activate_env() {
    local name=$(ls "$ENV_DIR" | fzf --tmux center --reverse)
    echo "source \"$ENV_DIR/$name/bin/activate\"" | pbcopy
    echo "activation command copied into clipboard"
}

remove_env() {
    local name=$(ls "$ENV_DIR" | fzf --tmux center --reverse)
    rm -rf "$ENV_DIR/$name"
    echo "removed environment $name"
}

main_menu() {
    gum style "python env manager"
    local choice=$(gum choose "create" "list" "activate" "remove" "exit")
    case $choice in
    create)
        create_env
        ;;
    list)
        list_envs
        ;;
    activate)
        activate_env
        ;;
    remove)
        remove_env
        ;;
    exit)
        exit 0
        ;;
    *)
        echo "invalid option"
        exit 1
        ;;
    esac
}

if [ "$#" -gt 0 ]; then
    case $1 in
    create)
        create_env
        ;;
    list)
        list_envs
        ;;
    activate)
        activate_env
        ;;
    remove)
        remove_env
        ;;
    *)
        echo "invalid command. available commands are: create, list, activate, remove"
        exit 1
        ;;
    esac
    exit 0
else
    main_menu
fi
