#!/usr/bin/env bash

FILE="$HOME/.config/polybar/blocks/scripts/rofi/colors.rasi"

# random accent color
COLORS=('#ee99a0' '#f5a97f' '#f4dbd6' '#f0c6c6' '#f5bde6' '#c6a0f6' '#ed8796' \
		'#eed49f' '#a6da95' '#8bd5ca' '#91d7e3' '#7dc4e4' '#8aadf4' '#b7bdf8')
AC="${COLORS[$(( $RANDOM % 14 ))]}"
sed -i -e "s/ac: .*/ac:   ${AC}FF;/g" $FILE
sed -i -e "s/se: .*/se:   ${AC}40;/g" $FILE

rofi -no-config \
     -no-lazy-grab \
     -no-show-match \
     -no-sort \
     -show calc \
     -modi calc \
		 -automatic-save-to-history \
		 -calc-command "echo -n '{result}' | xclip -selection clipboard" \
		 -hint-welcome " > Ctrl + return to save to clipboard" \
     -theme ~/.config/polybar/blocks/scripts/rofi/calc.rasi
