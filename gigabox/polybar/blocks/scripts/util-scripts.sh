# Configure options
toggle_safe_eyes=" Toggle safe eyes"
toggle_redshift=" Toggle redshift"
main_monitor_mode=" Turn on main monitor mode"
two_monitor_mode=" Turn on two monitor mode"
laptop_mode=" Turn on laptop mode"

options="$toggle_safe_eyes\n$toggle_redshift\n$main_monitor_mode\n$two_monitor_mode\n$laptop_mode"

dir="~/.config/polybar/blocks/scripts/rofi"
rofi_command="rofi -no-config -theme $dir/utilscripts.rasi"
chosen="$(echo -e "$options" | $rofi_command -p "Run util script..." -dmenu -selected-row 0)"

# TODO: Make gigabox dir environment variable to use instead of
#       hard-coding ~/projects/dotfiles-redux
#       Or, symlink scripts somewhere predictable
case $chosen in
    $toggle_safe_eyes)
        ~/projects/dotfiles-redux/gigabox/openbox/scripts/toggle-safeeyes.sh
        ;;
    $toggle_redshift)
        ~/projects/dotfiles-redux/gigabox/openbox/scripts/toggle-redshift.sh
        ;;
    $main_monitor_mode)
        ~/projects/dotfiles-redux/gigabox/openbox/scripts/main-only.sh
        ;;
    $two_monitor_mode)
        ~/projects/dotfiles-redux/gigabox/openbox/scripts/two-monitors.sh
        ;;
    $laptop_mode)
        ~/projects/dotfiles-redux/gigabox/openbox/scripts/laptop-only.sh
        ;;
esac

