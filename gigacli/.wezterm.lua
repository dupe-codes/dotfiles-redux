local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- TODO: cozette includes icons, picked up on fallback
--       explore how you feel with them, and (maybe) remap
--       the todo-comments icon for NOTE
config.font = wezterm.font_with_fallback {
    "Fantasque Sans Mono",
    "Rec Mono Duotone",
    "CommitMono-dupe",
    "Comic Mono",
    "MonoLisa Custom",
    "BerkeleyMono Nerd Font Mono",
    --'CozetteHiDpi',
    "Noto Sans Symbols",
}
config.color_scheme = "Tokyo Night"

config.leader = { key = "a", mods = "SUPER", timeout_milliseconds = 1000 }
config.window_background_opacity = 0.95
config.default_cursor_style = "BlinkingUnderline"
config.cursor_blink_rate = 650
config.hide_tab_bar_if_only_one_tab = true
config.animation_fps = 1
config.default_prog = { "/usr/bin/zsh" }
config.audible_bell = "Disabled"
config.warn_about_missing_glyphs = false

return config
