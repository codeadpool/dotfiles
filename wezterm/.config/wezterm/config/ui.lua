local wezterm = require 'wezterm'

local M = {}
function M.apply(config)
	--font settings
	config.font                    = wezterm.font_with_fallback {
		'JetBrainsMono Nerd Font'
	}
	config.font_size               = 13.0
	config.line_height             = 1.0
	config.max_fps                 = 120
	config.webgpu_power_preference = 'HighPerformance'
	config.window_decorations      = 'TITLE | RESIZE'
	config.cursor_blink_ease_in    = 'EaseOut'
	config.cursor_blink_ease_out   = 'EaseOut'
	config.default_cursor_style    = 'BlinkingBlock'
	config.cursor_blink_rate       = 650
	-- config.color_scheme            = 'tokyonight'
	-- config.colors                  = require 'colors.tokyonight'
end

return M
