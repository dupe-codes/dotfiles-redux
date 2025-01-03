#!/usr/bin/env bash

source "$HOME"/scripts/constants.sh
source "$HOME"/scripts/utils/logging.sh

if [ ! -d "$LOGS_DIR" ]; then
    print_warn "Logs directory $LOGS_DIR does not exist."
    exit 1
fi

if [ $# -gt 0 ]; then
    ARG_SUBDIR="$1"
    FULL_PATH="$LOGS_DIR/$ARG_SUBDIR"

    if [ ! -d "$FULL_PATH" ]; then
        print_fail "Provided argument is not a valid logs directory: $ARG_SUBDIR"
        exit 1
    fi
else
    SUBDIRS=$(find "$LOGS_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)

    if [ -z "$SUBDIRS" ]; then
        print_warn "No subdirectories found in $LOGS_DIR."
        exit 1
    fi

    SELECTED_DIR=$(echo "$SUBDIRS" | gum choose --header "Select a logs directory:")

    if [ -z "$SELECTED_DIR" ]; then
        print_info "No directory selected, exiting..."
        exit 0
    fi

    FULL_PATH="$LOGS_DIR/$SELECTED_DIR"
fi

LATEST_FILE=$(find "$FULL_PATH" -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -d' ' -f2-)

if [ -z "$LATEST_FILE" ]; then
    print_info "No log files found in $FULL_PATH."
    exit 0
fi

print_info "Tailing the latest log file: $LATEST_FILE"
echo -e "_________________________\n"
tail -f "$LATEST_FILE"
