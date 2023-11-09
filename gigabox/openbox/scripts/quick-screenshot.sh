#!/usr/bin/env bash

dir="$HOME/screenshots"
file="Screenshot_${time}_${geometry}.png"
icon1="$HOME/.config/dunst/icons/collections.svg"

notify_view () {
	dunstify -u low --replace=699 -i $icon1 "Copied to clipboard."
	viewnior ${dir}/"$file"
	if [[ -e "$dir/$file" ]]; then
		dunstify -u low --replace=699 -i $icon1 "Screenshot Saved."
	else
		dunstify -u low --replace=699 -i $icon1 "Screenshot Deleted."
	fi
}

cd ${dir} && maim -u -f png -i `xdotool getactivewindow` | tee "$file" | xclip -selection clipboard -t image/png
notify_view
