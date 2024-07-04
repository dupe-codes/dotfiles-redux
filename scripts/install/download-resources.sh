#! /bin/bash

# Download resources (wallpapers, fonts, etc.) from dropbox
wget -O $PWD/gigabox/resources.zip 'https://www.dropbox.com/sh/zff0e94426lpj95/AABiFP2pxBtgd-VgQRekbR33a?dl=1'

# the resources zip is _big_; unzip will get scared that it is a zip bomb
UNZIP_DISABLE_ZIPBOMB_DETECTION=TRUE unzip $PWD/gigabox/resources.zip -d $PWD/gigabox/resources/
rm $PWD/gigabox/resources.zip

cd $PWD/gigabox/resources/fonts/
for f in *.zip; do
    dir="${f%.*}"        # remove the .zip extension to get directory name
    mkdir -p "$dir"      # create the directory
    unzip -d "$dir" "$f" # unzip into the new directory
done

cd ../icons/
tar -xf Papirus-Dark-Custom.tar.xz
