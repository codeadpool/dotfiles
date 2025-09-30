local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

function M.apply(config)
	config.keys = {
		-- Split panes
		{ key = '|', mods = 'CTRL|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
		{ key = '-', mods = 'CTRL|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

		-- Navigate panes
		{ key = 'h', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Left' },
		{ key = 'l', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Right' },
		{ key = 'k', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Up' },
		{ key = 'j', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Down' },

		-- Copy mode
		{ key = 'c', mods = 'CTRL|SHIFT', action = act.ActivateCopyMode },
	}

	config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
end

return M
