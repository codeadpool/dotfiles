local wezterm = require 'wezterm'
local M = {}


local colors = {
	neon_blue    = '#00f7ff',
	neon_pink    = '#ff00ff',
	neon_green   = '#39ff14',
	neon_purple  = '#b300ff',
	dark_cyan    = '#1a3c4d',
	dark_grey    = '#0a0e14',
	bright_white = '#e0e0ff',
	dim_grey     = '#2a2e38',
	neon_red     = '#ff073a',
	black        = '#000000',

}


M.colors = {
	tab_bar = { background = colors.dark_grey, },
	tab_title = {
		bg = colors.black,
		fg_active = colors.neon_green,
		fg_inactive = colors.neon_purple,

	},
}

return M
