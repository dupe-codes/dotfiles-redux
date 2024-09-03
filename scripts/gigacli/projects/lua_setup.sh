#!/usr/bin/env bash

# TODO: refactor common logic for project setup (see godot_setup.sh)

source "$HOME/scripts/utils/logging.sh"
source "$HOME/scripts/constants.sh"

set -e

project_name=$(gum input --placeholder "project name")
if [ -z "$project_name" ]; then
    exit 0
fi

project_name_formatted=$(echo "$project_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')

cp -r "$TEMPLATES_DIR"/lua "$(pwd)"/"$project_name_formatted"
cp -r "$TEMPLATES_DIR"/common/. "$(pwd)"/"$project_name_formatted"

cd "$(pwd)"/"$project_name_formatted"
luarocks init --lua-versions "5.4"

# fill in project skeleton
sed -i "s/<project_name>/$project_name_formatted/g" Makefile project.env src/main.lua
mv src/main.lua src/"$project_name_formatted".lua

# append lua environment setup
project_env_file="project.env"
if [ -f "$project_env_file" ]; then
    cat >>"$project_env_file" <<EOL

export LUA_INIT="@src/setup.lua"
export PATH=\$PATH:./lua_modules/bin
EOL
else
    echo "Error: project.env file not found!"
    exit 1
fi

# update rockspec with default dependencies
dependencies=(
    "inspect >= 3.1"
    "ltui = 2.7"
    "ldoc = 1.5.0-1"
)

rockspec_file="$project_name_formatted-dev-1.rockspec"
if [ -f "$rockspec_file" ]; then
    for dependency in "${dependencies[@]}"; do
        sed -i "/dependencies = {/a \ \ \ \"$dependency\"," "$rockspec_file"
    done
    # update the main module definition
    sed -i "s|\(main = \)\"src/main.lua\"|\1\"src/$project_name_formatted.lua\"|" "$rockspec_file"
else
    echo "Error: rockspec file not found!"
    exit 1
fi

# initialize git config
git init
git add .
pre-commit install
pre-commit install -t prepare-commit-msg
git commit -m "feat: initialized project"

echo ""
print_info "Project $project_name created at $(pwd)"
