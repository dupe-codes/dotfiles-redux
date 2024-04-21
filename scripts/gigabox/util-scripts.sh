# Configure options
calculator=" Use calculator"
cheatsheets="󰎞 View cheatsheets"
note=" Take a quick note"
task=" Add a task to the quest log"
gpt=" Message ChatGPT"
clipboard=" View clipboard"
websites=" Visit bookmarked websites"
colors=" Change polybar colors"
wallpapers=" Manage favorite wallpapers"
toggle_safe_eyes=" Toggle safe eyes"
snooze_safe_eyes=" Snooze safe eyes"
toggle_redshift=" Toggle redshift"
snooze_redshift=" Snooze redshift"
toggle_notifications=" Toggle notifications"
main_monitor_mode=" Turn on main monitor mode"
two_monitor_mode=" Turn on two monitor mode"
laptop_mode=" Turn on laptop mode"
extended_laptop_mode=" Turn on laptop extend mode"

options="$calculator\n"\
"$cheatsheets\n"\
"$note\n"\
"$task\n"\
"$gpt\n"\
"$clipboard\n"\
"$websites\n"\
"$colors\n"\
"$wallpapers\n"\
"$toggle_safe_eyes\n"\
"$snooze_safe_eyes\n"\
"$toggle_redshift\n"\
"$snooze_redshift\n"\
"$toggle_notifications\n"\
"$main_monitor_mode\n"\
"$two_monitor_mode\n"\
"$laptop_mode\n"\
"$extended_laptop_mode\n"\
"$sync_polybar_colors\n"\
"$save_polybar_colors\n"\
"$load_polybar_colors\n"

dir="$HOME/scripts/gigabox/rofi"

rofi_command="rofi -no-config -theme $dir/utilscripts.rasi"
chosen="$(echo -e "$options" | $rofi_command -i -p "Run" -dmenu -selected-row 0)"

# TODO: Make gigabox dir environment variable to use instead of
#       hard-coding ~/projects/dotfiles-redux
#       Or, symlink scripts somewhere predictable
case $chosen in
    $calculator)
        $HOME/scripts/gigabox/calculator.sh
        ;;
    $cheatsheets)
        $HOME/scripts/gigabox/cheatsheets.sh
        ;;
    $note)
        $HOME/scripts/gigabox/quick-note.sh
        ;;
    $task)
        $HOME/scripts/gigabox/task.sh
        ;;
    $gpt)
        $HOME/scripts/gigabox/gpt-convo.sh
        ;;
    $clipboard)
        $HOME/scripts/gigabox/clipboard.sh
        ;;
    $websites)
        $HOME/scripts/gigabox/websites.sh
        ;;
    $colors)
        $HOME/scripts/gigabox/color-tools/chooser.sh
        ;;
    $wallpapers)
        $HOME/scripts/gigabox/wallpapers.sh
        ;;
    $toggle_safe_eyes)
        $HOME/.config/openbox/scripts/toggle-safeeyes.sh
        ;;
    $snooze_safe_eyes)
        $HOME/.config/openbox/scripts/toggle-safeeyes.sh --snooze
        ;;
    $toggle_redshift)
        $HOME/.config/openbox/scripts/toggle-redshift.sh
        ;;
    $snooze_redshift)
        $HOME/.config/openbox/scripts/toggle-redshift.sh --snooze
        ;;
    $toggle_notifications)
        $HOME/.config/openbox/scripts/toggle-dunst.sh
        ;;
    $main_monitor_mode)
        $HOME/.config/openbox/scripts/main-only.sh
        ;;
    $two_monitor_mode)
        $HOME/.config/openbox/scripts/two-monitors.sh
        ;;
    $laptop_mode)
        $HOME/.config/openbox/scripts/laptop-only.sh
        ;;
    $extended_laptop_mode)
        $HOME/.config/openbox/scripts/extended-laptop.sh
        ;;
esac

