local wezterm = require 'wezterm'
local M = {}

-- Load external color config
local color_scheme = require 'colors.cyber-purple'
local tab_colors = color_scheme.colors

-- Nerd Font arrows
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_left_half_circle_thick
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_right_half_circle_thick

function M.apply(config)
	config.enable_tab_bar = true
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = false
	config.hide_tab_bar_if_only_one_tab = false

	config.colors = config.colors or {}
	config.colors.tab_bar = tab_colors.tab_bar

	wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
		local is_active = tab.is_active
		local title = tab.active_pane.title
		local bg = tab_colors.tab_title.bg
		local fg = is_active and tab_colors.tab_title.fg_active or tab_colors.tab_title.fg_inactive
		local edge_fg = is_active and tab_colors.tab_title.edge_fg_active or tab_colors.tab_title.edge_fg_inactive

		return {
			{ Background = { Color = edge_fg } },
			{ Foreground = { Color = bg } },
			{ Text = SOLID_LEFT_ARROW },
			{ Background = { Color = bg } },
			{ Foreground = { Color = fg } },
			{ Text = ' ' .. title .. ' ' },
			{ Background = { Color = edge_fg } },
			{ Foreground = { Color = bg } },
			{ Text = SOLID_RIGHT_ARROW },
		}
	end)
end

return M
