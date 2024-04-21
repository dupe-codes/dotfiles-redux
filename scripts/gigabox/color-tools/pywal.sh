#!/usr/bin/env bash

# Color files
PFILE="$HOME/.config/polybar/blocks/colors.ini"
WFILE="$HOME/.cache/wal/colors.sh"

# Get colors
pywal_get() {
	wal -n -s -i "$1" -q -t
}

# Change colors
change_color() {
	# polybar
	sed -i -e "s/background = #.*/background = $BG/g" $PFILE
	sed -i -e "s/foreground = #.*/foreground = $FG/g" $PFILE
	sed -i -e "s/foreground-alt = #.*/foreground-alt = $FGA/g" $PFILE
	sed -i -e "s/primary = #.*/primary = $SH9/g" $PFILE
	sed -i -e "s/red = #.*/red = $SH1/g" $PFILE
	sed -i -e "s/pink = #.*/pink = $SH2/g" $PFILE
	sed -i -e "s/purple = #.*/purple = $SH3/g" $PFILE
	sed -i -e "s/blue = #.*/blue = $SH4/g" $PFILE
	sed -i -e "s/cyan = #.*/cyan = $SH5/g" $PFILE
	sed -i -e "s/teal = #.*/teal = $SH6/g" $PFILE
	sed -i -e "s/green = #.*/green = $SH7/g" $PFILE
	sed -i -e "s/lime = #.*/lime = $SH8/g" $PFILE
	sed -i -e "s/yellow = #.*/yellow = $SH9/g" $PFILE
	sed -i -e "s/amber = #.*/amber = $SH10/g" $PFILE
	sed -i -e "s/orange = #.*/orange = $SH11/g" $PFILE
	sed -i -e "s/brown = #.*/brown = $SH12/g" $PFILE
	sed -i -e "s/gray = #.*/gray = $SH13/g" $PFILE
	sed -i -e "s/indigo = #.*/indigo = $SH14/g" $PFILE
	sed -i -e "s/blue-gray = #.*/blue-gray = $SH15/g" $PFILE

	polybar-msg cmd restart
}

# Main
if [[ -x "`which wal`" ]]; then
	if [[ "$1" ]]; then
		pywal_get "$1"

		# Source the pywal color file
		if [[ -e "$WFILE" ]]; then
			. "$WFILE"
		else
			echo 'Color file does not exist, exiting...'
			exit 1
		fi

		BG=`printf "%s\n" "$background"`
		FG=`printf "%s\n" "$color0"`
		FGA=`printf "%s\n" "$color7"`
		SH1=`printf "%s\n" "$color1"`
		SH2=`printf "%s\n" "$color2"`
		SH3=`printf "%s\n" "$color3"`
		SH4=`printf "%s\n" "$color4"`
		SH5=`printf "%s\n" "$color5"`
		SH6=`printf "%s\n" "$color6"`
		SH7=`printf "%s\n" "$color7"`
		SH8=`printf "%s\n" "$color8"`
		SH9=`printf "%s\n" "$color9"`
		SH10=`printf "%s\n" "$color10"`
		SH11=`printf "%s\n" "$color11"`
		SH12=`printf "%s\n" "$color12"`
		SH13=`printf "%s\n" "$color13"`
		SH14=`printf "%s\n" "$color14"`
		SH15=`printf "%s\n" "$color15"`

		change_color
	else
		echo -e "[!] Please enter the path to wallpaper. \n"
		echo "Usage : ./pywal.sh path/to/image"
	fi
else
	echo "[!] 'pywal' is not installed."
fi
