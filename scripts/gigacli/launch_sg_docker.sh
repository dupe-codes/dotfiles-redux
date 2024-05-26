#!/usr/bin/env bash

source "$HOME"/scripts/utils/logging.sh

docker run -d \
    --publish 7080:7080 \
    --publish 127.0.0.1:3370:3370 \
    --rm \
    --volume ~/.sourcegraph/config:/etc/sourcegraph \
    --volume ~/.sourcegraph/data:/var/opt/sourcegraph \
    sourcegraph/server:5.3.3

print_ok "Sourcegraph docker container launched"
