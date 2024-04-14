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
confirm_update "doom upgrade"
confirm_update 'nvim --headless "+Lazy! sync" +qa'

# TODO: add pip, npm, go
