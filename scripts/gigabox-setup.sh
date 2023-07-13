# /bin/bash

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

        # check if line ends with "@yay"
        if [[ $line == *@yay ]]; then
            # remove @yay and add to yay list
            yay_pkgs+=" ${line%@yay}"
        else
            # add to pacman list
            pacman_pkgs+=" $line"
        fi
    done <"$FILE"

    if [ -n "$pacman_pkgs" ]; then
        echo "Installing packages with pacman..."
        sudo pacman -S --noconfirm $pacman_pkgs
    fi

    if [ -n "$yay_pkgs" ]; then
        echo "Installing packages with yay..."
        yay -S --noconfirm $yay_pkgs
    fi
}

echo "Setting up the GIGABOX...\n\n"

# Download yay package manager
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

install_packages_from_file $PWD/gigabox/packages.txt

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup default stable

# Download resources (wallpapers, fonts, etc.) from dropbox
# TODO: Include needed fonts and icons:
# 	Material
# 	Feather IcoMoon
# 	Papirus-Dark-Custom
wget -O $PWD/gigabox/resources.zip 'https://www.dropbox.com/sh/zff0e94426lpj95/AABiFP2pxBtgd-VgQRekbR33a?dl=0'
unzip $PWD/gigabox/resources.zip -d $PWD/gigabox/resources/

# Setup web-greeter login screen
git clone https://github.com/hertg/lightdm-neon.git
cd lightdm-neon
make build
sudo make install

# Setup dupe user image :]
sudo mkdir -p /var/lib/AccountsService/icons
sudo cp $PWD/gigabox/resources/dupe.png /var/lib/AccountsService/
sudo chmod 644 /var/lib/AccountsService/dupe.png
sudo mkdir -p /var/lib/AccountsService/users
sudo echo -e "[User]\nIcon=/var/lib/AccountsService/icons/dupe.png" > /var/lib/AccountsService/users/dupe
sudo chmod 644 /var/lib/AccountsService/users/dupe

# Enable services
sudo systemctl enable lightdm.service

