#!/bin/bash

# status logs
# 2025-03-09:
#   - yay failed to update zotero and python-future
#   - cargo update entirely failed

set -e

source "$HOME"/scripts/constants.sh
source "$HOME"/scripts/utils/logging.sh

log_timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
logging_dir="$LOGS_DIR/system-updates"
log_file="$logging_dir/system-update-$log_timestamp.log"
mkdir -p "$logging_dir"

confirm_update() {
    print_info "Updating $1..." | tee -a "$log_file"
    if gum confirm "Do you want to proceed with $1 update?"; then
        $2 | tee -a "$log_file"
    else
        print_info "Skipping $1 update." | tee -a "$log_file"
    fi
}

#EXCLUDED_PACKAGES=("mesa")
#PACKAGE_IGNORE=""
#if [ ${#EXCLUDED_PACKAGES[@]} -ne 0 ]; then
#PACKAGE_IGNORE="--ignore ${EXCLUDED_PACKAGES[*]}"
#fi

confirm_update "pacman" "sudo pacman -Syu $PACKAGE_IGNORE"
confirm_update "yay" "yay -Syu $PACKAGE_IGNORE"
confirm_update "cargo" "cargo install-update -a"
confirm_update "doom emacs" "doom upgrade"

# TODO: for neovim updates, how to surface success/failure?
#       this doesn't seem to work; debug
confirm_update "neovim" 'nvim --headless "+Lazy! sync" +qa'

# TODO: add pip, npm, go
# TODO: add nvim mason installed packages update
#       maybe just: nvim --headless "+MasonUpdate!" +qa

echo "Disk usage:"
HEADER=$(df -h | head -n 1)
DISK_USAGE=$(df -h | grep "/dev/nvme0n1p2")
echo "$HEADER"
echo "$DISK_USAGE"

