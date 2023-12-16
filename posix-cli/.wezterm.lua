local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font 'MonoLisa Custom'
config.color_scheme = 'Tokyo Night'
config.window_background_opacity = 0.95
config.default_cursor_style = 'BlinkingUnderline'
config.animation_fps = 1

config.default_prog = { '/usr/bin/xonsh' }

return config
