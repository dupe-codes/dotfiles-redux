# adapted from: https://github.com/olimorris

set -g @plugin 'tmux-plugins/tmux-cpu'           # Display CPU performance
set -g @plugin 'tmux-plugins/tmux-battery'       # Battery status in tmux
set -g @plugin 'MunifTanjim/tmux-mode-indicator' # Display current tmux mode

#color_bg="#2e323b"
#color_green="#98c379"
#color_red="#e06c75"
#color_blue="#61afef"
#color_purple="#c678dd"
#color_gray="#5c6370"
#color_buffer="#939aa3"

# from tokyo night moon pallete
color_bg="#222436"     # bg
color_green="#c3e88d"  # green
color_red="#ff757f"    # red
color_blue="#82aaff"   # blue
color_purple="#fca7ea" # purple
color_gray="#c8d3f5"   # fg
color_buffer="#828bb8" # fg_dark

#color_selection="#3e4452"
#color_fg="#282c34"
#color_cyan="#56b6c2"
#color_yellow="#e5c07b"

#################################### PLUGINS ###################################

set -g @mode_indicator_prefix_prompt "WAIT"
set -g @mode_indicator_prefix_mode_style fg=$color_blue,bold
set -g @mode_indicator_copy_prompt "COPY"
set -g @mode_indicator_copy_mode_style fg=$color_green,bold
set -g @mode_indicator_sync_prompt "SYNC"
set -g @mode_indicator_sync_mode_style fg=$color_red,bold
set -g @mode_indicator_empty_prompt "TMUX"
set -g @mode_indicator_empty_mode_style fg=$color_purple,bold

# tmux cpu
set -g @cpu_percentage_format "%3.0f%%"

# tmux-battery
set -g @batt_icon_charge_tier8 ""
set -g @batt_icon_charge_tier7 ""
set -g @batt_icon_charge_tier6 ""
set -g @batt_icon_charge_tier5 ""
set -g @batt_icon_charge_tier4 ""
set -g @batt_icon_charge_tier3 ""
set -g @batt_icon_charge_tier2 ""
set -g @batt_icon_charge_tier1 ""

set -g @batt_icon_status_charged " "
set -g @batt_icon_status_charging "  "
set -g @batt_icon_status_discharging " "
set -g @batt_icon_status_attached " "
set -g @batt_icon_status_unknown " "

set -g @batt_remain_short true

#################################### OPTIONS ###################################

set -g status on
set -g status-justify centre
set -g status-left-length 90
set -g status-right-length 90
set -g status-style "bg=default"

set -g message-style bg=$color_blue,fg=$color_bg
setw -g window-status-separator "   "
set-window-option -g mode-style bg=$color_purple,fg=$color_bg

#################################### FORMAT ####################################

set -g status-left "#{tmux_mode_indicator} #[fg=$color_blue,bold]#S"
set -g status-right "#[fg=$color_gray]#{battery_icon_charge}  #{battery_percentage}#{battery_icon_status}#{battery_remain} | CPU:#{cpu_percentage} | #[fg=$color_gray]%R"
setw -g window-status-format "#[fg=$color_gray,italics]#I: #[noitalics]#W"
setw -g window-status-current-format "#[fg=$color_purple,italics]#I: #[fg=$color_buffer,noitalics,bold]#W"
