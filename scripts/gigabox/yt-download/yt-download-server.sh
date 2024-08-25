#!/bin/bash

#
# Simple bash server exposing youtube video download capabilities
# via yt-dlp
#
# We call this "slurping" the video :)
#
# To slurp the current youtube video in the browser, run this JS snippet:
#
# (function() {
#    var url = window.location.href;
#    var xhr = new XMLHttpRequest();
#    xhr.open("GET", "http://localhost:8123?url=" + encodeURIComponent(url), true);
#    xhr.send();
# })();
#

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
DEST_DIR="$HOME/Dropbox/videos"

RESPONSE_PIPE_DIR="$HOME/.local/state/yt-download"
if [ ! -d "$RESPONSE_PIPE_DIR" ]; then
    mkdir -p "$RESPONSE_PIPE_DIR"
fi
RESPONSE_PIPE_FILE="$RESPONSE_PIPE_DIR/response"
rm -f "$RESPONSE_PIPE_FILE"
mkfifo "$RESPONSE_PIPE_FILE"

function handle_OPTIONS {
    RESPONSE="HTTP/1.1 204 No Content\r\n"
    RESPONSE+="Access-Control-Allow-Origin: *\r\n"
    RESPONSE+="Access-Control-Allow-Methods: GET, POST, OPTIONS\r\n"
    RESPONSE+="Access-Control-Allow-Headers: Content-Type\r\n"
    RESPONSE+="Content-Length: 0\r\n\r\n"

}

function handle_GET_url {
    url="${REQUEST#GET /?url=}"
    url="${url%% *}"               # Remove trailing HTTP version info
    url=$(echo -e "${url//%/\\x}") # Decode URL

    if [[ ! "$url" =~ youtube.com ]]; then
        notify-send "yt-download-server" "Received non-youtube URL: $url"
        RESPONSE="HTTP/1.1 400 Bad Request\r\n"
        RESPONSE+="Content-Type: text/html\r\n"
        RESPONSE+="Access-Control-Allow-Origin: *\r\n\r\n"
        RESPONSE+="Invalid URL: $url"
        return
    fi

    notify-send "yt-download-server" "Downloading video at: $url"

    # download with best available resolution
    yt-dlp "$url" -f 'bv*[height<=1080]+ba/bestvideo[height<=1080]+bestaudio/best' \
        --no-playlist \
        --write-subs \
        -P "$DEST_DIR" |
        tee -a "$log_file"
    yt_dlp_status=$?

    if [ "$yt_dlp_status" -ne 0 ]; then
        notify-send "yt-download-server" "Failed to download video at: $url"
        RESPONSE="HTTP/1.1 500 Internal Server Error\r\n"
        RESPONSE+="Content-Type: text/html\r\n"
        RESPONSE+="Access-Control-Allow-Origin: *\r\n\r\n"
        RESPONSE+="Failed to download video at: $url"
        return
    fi

    notify-send "yt-download-server" "Downloaded video at: $url"

    RESPONSE="HTTP/1.1 200 OK\r\n"
    RESPONSE+="Content-Type: text/html\r\n"
    RESPONSE+="Access-Control-Allow-Origin: *\r\n\r\n"
    RESPONSE+="Downloaded video at: $url"
}

function handleRequest() {
    while read -r line; do
        print_info "Received: $line" | tee -a "$log_file"

        trline=$(echo "$line" | tr -d '[\r\n]')

        [ -z "$trline" ] && break

        HEADLINE_REGEX='(.*?)\s(.*?)\sHTTP.*?'

        [[ "$trline" =~ $HEADLINE_REGEX ]] &&
            REQUEST=$(echo "$trline" | sed -E "s/$HEADLINE_REGEX/\1 \2/")

    done

    print_info "Parsed request: $REQUEST\n" | tee -a "$log_file"

    case "$REQUEST" in
    "OPTIONS "*) handle_OPTIONS ;;
    "GET /?url="*) handle_GET_url ;;
    *) RESPONSE="HTTP/1.1 404 NotFound\r\n\r\n\r\nNot Found" ;;
    esac

    print_info "Sending response: $RESPONSE\n" | tee -a "$log_file"
    echo -e "$RESPONSE" >"$RESPONSE_PIPE_FILE"
}

print_info "Starting server on port $PORT\n" | tee -a "$log_file"

while true; do
    cat "$RESPONSE_PIPE_FILE" | nc -lN "$PORT" | handleRequest
done
