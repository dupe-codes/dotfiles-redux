#!/usr/bin/env bash

# simple script to setup godot projects based on my preferred
# structure

source "$HOME/scripts/utils/logging.sh"

project_name=$(gum input --placeholder "project name")
if [ -z "$project_name" ]; then
    exit 0
fi

project_dir=$(echo "$project_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')

# TODO: add "TEMPLATES_DIR" to constants file
cp -r "$HOME"/projects/dotfiles-redux/project-configs/templates/godot "$(pwd)"/"$project_dir"

cd "$(pwd)"/"$project_dir" &&
    sed -i "s/<project_name>/$project_name/g" project.godot &&
    git init &&
    git add . &&
    git commit -m "feat: initialized project"

echo ""
print_info "Project $project_name created at $(pwd)/$project_dir"
