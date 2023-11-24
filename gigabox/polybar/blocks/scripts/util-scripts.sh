# Configure options
calculator=" Use calculator"
cheatsheets="󰎞 View cheatsheets"
note=" Take a note"
gpt=" Message ChatGPT"
clipboard=" View clipboard"
websites=" Visit bookmarked websites"
toggle_safe_eyes=" Toggle safe eyes"
toggle_redshift=" Toggle redshift"
toggle_notifications=" Toggle notifications"
sync_polybar_colors=" Sync polybar colors"
save_polybar_colors=" Save polybar colors"
load_polybar_colors=" Load polybar colors"
main_monitor_mode=" Turn on main monitor mode"
two_monitor_mode=" Turn on two monitor mode"
laptop_mode=" Turn on laptop mode"

options="$calculator\n"\
"$cheatsheets\n"\
"$note\n"\
"$gpt\n"\
"$clipboard\n"\
"$websites\n"\
"$toggle_safe_eyes\n"\
"$toggle_redshift\n"\
"$toggle_notifications\n"\
"$main_monitor_mode\n"\
"$two_monitor_mode\n"\
"$laptop_mode\n"\
"$sync_polybar_colors\n"\
"$save_polybar_colors\n"\
"$load_polybar_colors\n"

dir="~/.config/polybar/blocks/scripts/rofi"
rofi_command="rofi -no-config -theme $dir/utilscripts.rasi"
chosen="$(echo -e "$options" | $rofi_command -i -p "Run" -dmenu -selected-row 0)"

# TODO: Make gigabox dir environment variable to use instead of
#       hard-coding ~/projects/dotfiles-redux
#       Or, symlink scripts somewhere predictable
case $chosen in
    $calculator)
        ~/projects/dotfiles-redux/gigabox/polybar/blocks/scripts/calculator.sh
        ;;
    $cheatsheets)
        ~/projects/dotfiles-redux/gigabox/polybar/blocks/scripts/cheatsheets.sh
        ;;
    $note)
        ~/projects/dotfiles-redux/gigabox/polybar/blocks/scripts/note-taking.sh
        ;;
    $gpt)
        ~/projects/dotfiles-redux/gigabox/polybar/blocks/scripts/gpt-convo.sh
        ;;
    $clipboard)
        ~/projects/dotfiles-redux/gigabox/polybar/blocks/scripts/clipboard.sh
        ;;
    $websites)
        ~/projects/dotfiles-redux/gigabox/polybar/blocks/scripts/websites.sh
        ;;
    $toggle_safe_eyes)
        ~/projects/dotfiles-redux/gigabox/openbox/scripts/toggle-safeeyes.sh
        ;;
    $toggle_redshift)
        ~/projects/dotfiles-redux/gigabox/openbox/scripts/toggle-redshift.sh
        ;;
    $sync_polybar_colors)
        ~/projects/dotfiles-redux/gigabox/polybar/blocks/scripts/sync-polybar-colors.sh
        ;;
    $save_polybar_colors)
        ~/projects/dotfiles-redux/gigabox/polybar/blocks/scripts/save-colors.sh
        ;;
    $load_polybar_colors)
        ~/projects/dotfiles-redux/gigabox/polybar/blocks/scripts/load-colors.sh
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

