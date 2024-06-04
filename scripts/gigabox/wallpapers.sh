#!/usr/bin/env bash

favorites_file="$HOME/projects/dotfiles-redux/gigabox/favorite-wallpapers.txt"
wallpapers_dir="$HOME/projects/dotfiles-redux/gigabox/resources/wallpapers"
cache_dir="${HOME}/.cache/$(whoami)/wallpaper-previews"

if [ ! -d "${cache_dir}" ]; then
    mkdir -p "${cache_dir}"
fi

get_current_wallpaper() {
    grep -E '^file=' ~/.config/nitrogen/bg-saved.cfg | cut -d'=' -f2-
}

create_wallpaper_previews() {
    # convert favorite images in directory and save to cache dir
    local -a favorites=("$@")
    for img_name in "${favorites[@]}"; do
        local image_path="${wallpapers_dir}/${img_name}"
        if [ -f "$image_path" ]; then
            if [ ! -f "${cache_dir}/${img_name}" ]; then
                convert -strip "$image_path" -thumbnail 500x500^ -gravity center -extent 500x500 "${cache_dir}/${img_name}"
            fi
        fi
    done
}

# choose wallpaper action

save_wallpaper=" Save wallpaper as favorite"
load_wallpaper=" Load favorite wallpaper"

options="$save_wallpaper\n\
$load_wallpaper\n"

dir="$HOME/scripts/gigabox/rofi"
rofi_command="rofi -no-config -theme $dir/utilscripts.rasi"
chosen="$(echo -e "$options" | $rofi_command -i -p "Run" -dmenu -selected-row 0)"

case $chosen in
$save_wallpaper)
    WALLPAPER_PATH=$(get_current_wallpaper)
    WALLPAPER_NAME=$(basename "$WALLPAPER_PATH")
    touch "$favorites_file"
    if grep -Fxq "$WALLPAPER_NAME" "$favorites_file"; then
        notify-send "Wallpaper" "$WALLPAPER_NAME is already a favorite."
    else
        echo "$WALLPAPER_NAME" >>"$favorites_file"
        notify-send "Wallpaper" "$WALLPAPER_NAME saved as favorite."
    fi
    ;;
$load_wallpaper)

    monitor_res=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f1)
    monitor_scale=$(xdpyinfo | awk '/resolution/{print $2}' | cut -d 'x' -f1)
    monitor_res=$((monitor_res * 17 / monitor_scale))
    rofi_override="element-icon{size:${monitor_res}px;border-radius:0px;}"

    if [ -f "$favorites_file" ]; then
        mapfile -t favorites <"$favorites_file"
        create_wallpaper_previews "${favorites[@]}"

        # generate list for Rofi with icons
        rofi_list=""
        for favorite in "${favorites[@]}"; do
            if [ -f "${cache_dir}/${favorite}" ]; then
                rofi_list+="${favorite}\x00icon\x1f${cache_dir}/${favorite}\n"
            fi
        done

        rofi_command="rofi -no-config -theme $dir/file-preview.rasi"
        selection=$(echo -e "$rofi_list" | $rofi_command -dmenu -i -p "Select wallpaper" -theme-str "$rofi_override")
        if [ -n "$selection" ]; then
            nitrogen --set-zoom-fill --save "$wallpapers_dir/$selection"
            notify-send "Wallpaper" "$selection loaded."
        fi
    else
        notify-send "Wallpaper" "No favorite wallpapers found."
    fi
    ;;
esac
