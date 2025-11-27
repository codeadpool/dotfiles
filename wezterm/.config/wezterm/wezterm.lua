local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.enable_wayland = false
config.warn_about_missing_glyphs = false

local ui = require("config.ui")
local tabs = require("config.tabs")
local windows = require("config.windows")
local keybindings = require("config.keybindings")

ui.apply(config)
tabs.apply(config)
windows.apply(config)
keybindings.apply(config)

return config
