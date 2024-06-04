# /bin/bash

# Download resources (wallpapers, fonts, etc.) from dropbox
# TODO: Include needed fonts and icons:
# 	Material
# 	Feather IcoMoon
# 	Papirus-Dark-Custom
wget -O $PWD/gigabox/resources.zip 'https://www.dropbox.com/sh/zff0e94426lpj95/AABiFP2pxBtgd-VgQRekbR33a?dl=1'
unzip $PWD/gigabox/resources.zip -d $PWD/gigabox/resources/
rm $PWD/gigabox/resources.zip

cd $PWD/gigabox/resources/fonts/
for f in *.zip; do
    dir="${f%.*}"        # remove the .zip extension to get directory name
    mkdir -p "$dir"      # create the directory
    unzip -d "$dir" "$f" # unzip into the new directory
done

cd ../icons/
tar -xf Papirus-Dark-Custom.tar.xz
