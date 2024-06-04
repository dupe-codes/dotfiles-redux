#!/bin/bash

# set -x

for path in "$@"; do
    if [[ "${path}" != -* ]]; then
        dst=${path##*/}

        # find a filename that doesn't exist
        while [[ -e "$HOME/trash/$dst" ]]; do
            dst="$dst-$(/bin/date +%H-%M-%S)"
        done

        if [[ -f "${path}" || -d "${path}" ]]; then
            /bin/mv "${path}" "$HOME/trash/$dst"
            echo "Moved ${path} to $HOME/trash/$dst"
        fi

    fi
done
