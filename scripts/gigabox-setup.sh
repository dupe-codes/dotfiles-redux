# /bin/bash

# Download yay package manager
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

# TODO: download and install packages

# Download resources (wallpapers, fonts, etc.) from dropbox
mkdir -p $HOME/gigabox
wget -O $HOME/gigabox/resources.zip 'https://www.dropbox.com/sh/zff0e94426lpj95/AABiFP2pxBtgd-VgQRekbR33a?dl=0'
unzip $HOME/gigabox/resources.zip -d $HOME/gigabox/

# TODO: Link icons to /usr/share/icons and ~/.icons
#       Need to find good icon pack options
# TODO: Link fonts to ~/.fonts
#       Need to find good font with icon options

# TODO: Link all configuration files

# Enable services
sudo systemctl enable lightdm.service

