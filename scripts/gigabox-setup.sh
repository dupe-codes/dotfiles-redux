# Download yay package manager
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

# TODO: download and install packages

# Download resources (wallpapers, fonts, etc.) from dropbox
wget -O $PWD/gigabox/gigabox-resources.zip 'https://www.dropbox.com/sh/zff0e94426lpj95/AABiFP2pxBtgd-VgQRekbR33a?dl=0'
unzip $PWD/gigabox/gigabox-resources.zip

# Enable services
sudo systemctl enable lightdm.service

