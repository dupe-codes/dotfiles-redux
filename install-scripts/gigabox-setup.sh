# /bin/bash

# TODO:
#   1. wrap coherent chunks of code into functions
#   2. create util script with common helpers (e.g. "log" function)
#       to import and use in all setup scripts
#   3. download obsidian and configure the datastore vault

install_packages_from_file() {
    FILE=$1
    pacman_pkgs=""
    yay_pkgs=""

    while IFS= read -r line
    do
        # skip comments
        if [[ $line == \#* ]]; then
            continue
        fi

        if [[ $line == *@yay ]]; then
            yay_pkgs+=" ${line%@yay}"
        else
            pacman_pkgs+=" $line"
        fi
    done <"$FILE"

    if [ -n "$pacman_pkgs" ]; then
        echo "Installing packages with pacman..."
        sudo pacman -S $pacman_pkgs
    fi

    if [ -n "$yay_pkgs" ]; then
        echo "Installing packages with yay..."
        yay -S $yay_pkgs
    fi
}

echo "Setting up the GIGABOX...\n\n"

# Download yay package manager
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..

install_packages_from_file $PWD/gigabox/packages.txt

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
rustup default stable

# Setup web-greeter login screen
git clone https://github.com/hertg/lightdm-neon.git
cd lightdm-neon
make build
sudo make install

# Enable services
sudo systemctl enable lightdm.service
sudo systemctl enable bluetooth.service
sudo systemctl enable NetworkManager.sevice
sudo systemctl enable clamav-freshclam.service
sudo systemctl enable clamav-daemon.service
sudo systemctl enable logid.service
sudo systemctl enable atd
systemctl --user enable pulseaudio

