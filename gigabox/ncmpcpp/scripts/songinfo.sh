#!/bin/sh

music_dir="$HOME/Music"
previewdir="$HOME/.config/ncmpcpp/previews"
filename="$(mpc -h 127.0.0.1 -p 7777 --format "$music_dir"/%file% current)"
previewname="$previewdir/$(mpc -h 127.0.0.1 -p 7777 --format %album% current | base64).png"

[ -e "$previewname" ] || ffmpeg -y -i "$filename" -an -vf scale=128:128 "$previewname" > /dev/null 2>&1

notify-send -r 27072 "Now Playing" "$(mpc -h 127.0.0.1 -p 7777 --format '%title% \n%artist% - %album%' current)" -i "$previewname"

