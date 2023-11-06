# Configure options
calculator=" Use calculator"
keybinds=" View keybinds"
note=" Take a note"
toggle_safe_eyes=" Toggle safe eyes"
toggle_redshift=" Toggle redshift"
toggle_notifications=" Toggle notifications"
main_monitor_mode=" Turn on main monitor mode"
two_monitor_mode=" Turn on two monitor mode"
laptop_mode=" Turn on laptop mode"

options="$calculator\n$keybinds\n$note\n$toggle_safe_eyes\n$toggle_redshift\n$toggle_notifications\n$main_monitor_mode\n$two_monitor_mode\n$laptop_mode"

dir="~/.config/polybar/blocks/scripts/rofi"
rofi_command="rofi -no-config -theme $dir/utilscripts.rasi"
chosen="$(echo -e "$options" | $rofi_command -p "Run" -dmenu -selected-row 0)"

# TODO: Make gigabox dir environment variable to use instead of
#       hard-coding ~/projects/dotfiles-redux
#       Or, symlink scripts somewhere predictable
case $chosen in
    $calculator)
        ~/projects/dotfiles-redux/gigabox/polybar/blocks/scripts/calculator.sh
        ;;
    $keybinds)
        ~/projects/dotfiles-redux/gigabox/polybar/blocks/scripts/keybinds.sh
        ;;
    $note)
        ~/projects/dotfiles-redux/gigabox/polybar/blocks/scripts/note-taking.sh
        ;;
    $toggle_safe_eyes)
        ~/projects/dotfiles-redux/gigabox/openbox/scripts/toggle-safeeyes.sh
        ;;
    $toggle_redshift)
        ~/projects/dotfiles-redux/gigabox/openbox/scripts/toggle-redshift.sh
        ;;
    $toggle_notifications)
        ~/projects/dotfiles-redux/gigabox/openbox/scripts/toggle-dunst.sh
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

