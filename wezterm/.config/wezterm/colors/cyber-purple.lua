local wezterm = require 'wezterm'

local M = {}

-- Define colors
local colors = {
	neon_blue    = '#00f7ff', -- Bright cyan for primary accents
	neon_pink    = '#ff00ff', -- Vibrant magenta for highlights
	neon_green   = '#39ff14', -- Electric green for active elements
	neon_purple  = '#b300ff', -- Deep purple for secondary accents
	dark_cyan    = '#1a3c4d', -- Dark teal for backgrounds
	dark_grey    = '#0a0e14', -- Near-black for base background
	bright_white = '#e0e0ff', -- Slightly tinted white for text
	dim_grey     = '#2a2e38', -- Muted grey for inactive elements
	neon_red     = '#ff073a', -- Bright red for errors or terminal mode
	black        = '#000000',
}

M.colors = {
	tab_bar = {
		background = colors.dim_grey,

		active_tab = {
			bg_color = colors.dark_cyan,
			fg_color = colors.neon_green,
		},
		inactive_tab = {
			bg_color = colors.dark_cyan,
			fg_color = colors.neon_purple,
		},
		inactive_tab_hover = {
			bg_color = colors.dark_cyan,
			fg_color = colors.neon_blue,
		},
		new_tab = {
			bg_color = colors.dim_grey,
			fg_color = colors.neon_green,
		},
		new_tab_hover = {
			bg_color = colors.dim_grey,
			fg_color = colors.neon_blue,
		},
	},

	tab_title = {
		bg = colors.neon_green,
		fg_active = colors.black,
		fg_inactive = colors.black,
		edge_fg_active = colors.black,
		edge_fg_inactive = colors.dim_grey,
	},

	window_frame = {
		active_titlebar_bg   = colors.dark_grey,
		inactive_titlebar_bg = colors.dark_grey,
		button_fg            = colors.neon_pink,
		button_bg            = colors.dark_grey,
		button_hover_fg      = colors.neon_blue,
		button_hover_bg      = colors.dark_grey,
		font                 = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Bold' }),
		font_size            = 11.0,
	},
}

return M
