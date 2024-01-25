local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback { 'MonoLisa Custom', 'Noto Sans Symbols' }
config.color_scheme = 'Tokyo Night'
config.window_background_opacity = 0.95
config.default_cursor_style = 'BlinkingUnderline'
config.hide_tab_bar_if_only_one_tab = true
config.animation_fps = 1
config.default_prog = { '/usr/bin/zsh' }

return config
