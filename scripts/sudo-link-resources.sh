# /bin/bash

sudo ln -vsf $PWD/gigabox/resources/icons/Papirus-Dark-Custom /usr/share/icons
sudo ln -vsf $PWD/gigabox/lightdm/lightdm.conf /etc/lightdm/lightdm.conf
sudo ln -vsf $PWD/gigabox/lightdm/web-greeter.yml /etc/lightdm/web-greeter.yml
sudo ln -vsf $PWD/gigabox/resources/wallpapers /usr/share/backgrounds

# Setup dupe user image :]
sudo mkdir -p /var/lib/AccountsService/icons
sudo cp $PWD/gigabox/resources/dupe.png /var/lib/AccountsService/icons
sudo chmod 644 /var/lib/AccountsService/icons/dupe.png
sudo mkdir -p /var/lib/AccountsService/users
sudo bash -c 'echo -e "[User]\nIcon=/var/lib/AccountsService/icons/dupe.png" > /var/lib/AccountsService/users/dupe'
sudo chmod 644 /var/lib/AccountsService/users/dupe

