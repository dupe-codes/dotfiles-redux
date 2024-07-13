#!/usr/bin/env bash

# simple script to setup godot projects based on my preferred
# structure

source "$HOME/scripts/utils/logging.sh"
source "$HOME/scripts/constants.sh"

set -e

project_name=$(gum input --placeholder "project name")
if [ -z "$project_name" ]; then
    exit 0
fi

project_dir=$(echo "$project_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')

cp -r "$TEMPLATES_DIR"/godot "$(pwd)"/"$project_dir"
cp -r "$TEMPLATES_DIR"/common/. "$(pwd)"/"$project_dir"

cd "$(pwd)"/"$project_dir" ||
    (print_fail "Failed to enter newly created project directory" &&
        exit 1)

# replace project name template strings
sed -i "s/<project_name>/$project_name/g" project.godot project.env

# initialize git repo
git init
git add .
pre-commit install
pre-commit install -t prepare-commit-msg
git commit -m "feat: initialized project"

echo ""
print_info "Project $project_name created at $(pwd)"
