#!/bin/bash

confirm_update() {
    if gum confirm "Do you want to proceed with $1 update?"; then
        $1
    else
        echo "Skipping $1 update."
    fi
}

confirm_update "sudo pacman -Syu"
confirm_update "yay -Syu"
confirm_update "cargo install-update -a"

# TODO: add pip, npm, and go
