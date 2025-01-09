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
    print_info "Backing up repository at $repo_path\n" | tee -a "$log_file"
    cd "$repo_path" || exit

    git add --all 2>&1 | tee -a "$log_file"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    git commit -m "chore(backups): $timestamp" 2>&1 | tee -a "$log_file"
    git push origin main 2>&1 | tee -a "$log_file"
    echo ""
    print_ok "Backup successful for $repo_path" | tee -a "$log_file"
}

for repo_path in "${REPO_PATHS[@]}"; do
    backup_repo "$repo_path"
done
