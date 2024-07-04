#!/bin/bash

set -e

source "$HOME"/scripts/constants.sh
source "$HOME"/scripts/utils/logging.sh

# TODO: create a helper function in utils/logging.sh
#       for creating these log files
log_timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
logging_dir="$LOGS_DIR/yt-downloads/"
log_file="$logging_dir/server-$log_timestamp.txt"

if [ ! -d "$logging_dir" ]; then
    mkdir -p "$logging_dir"
fi

PORT=8123

# TODO: this doesn't work well; revamp it to follow
# https://dev.to/leandronsp/building-a-web-server-in-bash-part-ii-parsing-http-14kg
#
# Ultimately, we want to grab the url and execute yt-dlp with it
# Then add this js snippet as a bookmark in vivaldi:
#
# (function() {
#    var url = window.location.href;
#    var xhr = new XMLHttpRequest();
#    xhr.open("GET", "http://localhost:8080?url=" + encodeURIComponent(url), true);
#    xhr.send();
# })();
#
while true; do
    print_info "Starting server on port $PORT" | tee -a "$log_file"

    nc -l -p $PORT | while read -r line; do
        if [[ $line =~ GET.*url=([^[:space:]]*) ]]; then
            url=${BASH_REMATCH[1]}
            url=$(echo -e "${url//%/\\x}")
            print_info "Received URL: $url" | tee -a "$log_file"
        fi
        echo -ne "HTTP/1.1 200 OK\r\nContent-Length: 2\r\n\r\nOK"
    done
done
