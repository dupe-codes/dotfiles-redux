#!/usr/bin/env bash

FILE="$HOME/scripts/gigabox/rofi/colors.rasi"

# random accent color
COLORS=('#ee99a0' '#f5a97f' '#f4dbd6' '#f0c6c6' '#f5bde6' '#c6a0f6' '#ed8796' \
		'#eed49f' '#a6da95' '#8bd5ca' '#91d7e3' '#7dc4e4' '#8aadf4' '#b7bdf8')
AC="${COLORS[$(( $RANDOM % 14 ))]}"
sed -i -e "s/ac: .*/ac:   ${AC}FF;/g" $FILE
sed -i -e "s/se: .*/se:   ${AC}40;/g" $FILE

rofi -no-config -no-lazy-grab -show drun -modi drun -theme $HOME/scripts/gigabox/rofi/launcher.rasi
