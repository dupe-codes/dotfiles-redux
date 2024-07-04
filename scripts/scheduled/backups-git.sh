#!/bin/bash

set -e

source "$HOME"/scripts/constants.sh
source "$HOME"/scripts/utils/logging.sh

log_timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
logging_dir="$LOGS_DIR/git-backups/"
log_file="$logging_dir/git-backups-$log_timestamp.txt"
mkdir -p "$LOGS_DIR"

REPO_PATHS=(
    "$HOME/datastore"
)

backup_repo() {
    local repo_path="$1"
    print_info "Backing up repository at $repo_path" >>"$log_file"
    cd "$repo_path" || exit

    git add --all >>"$log_file" 2>&1
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    git commit -m "chore(backups): $timestamp" >>"$log_file" 2>&1
    git push origin main >>"$log_file" 2>&1
    print_ok "Backup successful for $repo_path" >>"$log_file"
}

for repo_path in "${REPO_PATHS[@]}"; do
    backup_repo "$repo_path"
done
