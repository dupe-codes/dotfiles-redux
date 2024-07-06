#! /bin/bash

# TODO:
#   1. wrap coherent chunks of code into functions
#   2. create util script with common helpers (e.g. "log" function)
#       to import and use in all setup scripts
#   3. download obsidian and configure the datastore vault

install_packages() {
    PACKAGES_FILE=$1

    if [ "$SETUP" == "gigapc" ]; then
        SETUP="gigapc"
    elif [ "$SETUP" == "gigatop" ]; then
        SETUP="gigatop"
    else
        echo "Error: SETUP environment variable is not set to gigapc or gigatop."
        return 1
    fi

    install_section() {
        local section=$1
        local manager=$2

        packages=$(yq eval ".${section} | keys" -o csv "$PACKAGES_FILE" | tr -d '"' | tr ',' ' ')

        for package in $packages; do
            version=$(yq eval ".${section}.${package}" "$PACKAGES_FILE")
            if [ "$version" == "latest" ]; then
                if [ "$manager" == "default" ]; then
                    sudo pacman -S --noconfirm "$package"
                elif [ "$manager" == "yay" ]; then
                    yay -S --noconfirm "$package"
                fi
            else
                if [ "$manager" == "default" ]; then
                    sudo pacman -S --noconfirm "$package"="$version"
                elif [ "$manager" == "yay" ]; then
                    yay -S --noconfirm "$package"="$version"
                fi
            fi
        done
    }

    install_section "common.default" "default"
    install_section "common.yay" "yay"

    install_section "${SETUP}.default" "default"
    install_section "${SETUP}.yay" "yay"
}

echo "Setting up the GIGABOX...\n\n"

# Download yay package manager
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..

# install yq, needed for parsing the package.toml file
sudo pacman -S yq
install_packages "$PWD"/gigabox/packages.txt

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
rustup default stable

# Setup web-greeter login screen
git clone https://github.com/hertg/lightdm-neon.git
cd lightdm-neon
make build
sudo make install
cd ..

# Enable services
sudo systemctl enable lightdm.service
sudo systemctl enable bluetooth.service
sudo systemctl enable NetworkManager.sevice
sudo systemctl enable clamav-freshclam.service
sudo systemctl enable clamav-daemon.service
sudo systemctl enable logid.service
sudo systemctl enable atd
systemctl --user enable pulseaudio

# set up keyboard remappings
devices=("keychron" "laptop")
for device in "${devices[@]}"; do
    sudo cp "gigabox/evremap/$device-remap.service" /usr/lib/systemd/system/
    sudo cp "gigabox/evremap/$device.toml" "/etc/$device.toml"
    sudo systemctl enable "$device-remap.service"
done
