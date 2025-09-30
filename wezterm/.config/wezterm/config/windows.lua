local wezterm = require 'wezterm'
local colors = require 'colors.cyber-purple'

local M = {}

function M.apply(config)
	config.window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 10,
	}
	config.window_decorations = 'TITLE | RESIZE'
	config.initial_cols = 80
	config.initial_rows = 24
	wezterm.on('format-window-title', function()
		return "shadow-monarch@shadow-domain"
	end)
	config.window_frame = colors.colors.window_frame
end

return M
