local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

function M.apply(config)
	config.keys = {
		-- New tabs
		{ key = "T", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab "CurrentPaneDomain", },
		{ key = "1", mods = "CTRL",       action = wezterm.action.ActivateTab(0) },
		{ key = "2", mods = "CTRL",       action = wezterm.action.ActivateTab(1) },
		{ key = "3", mods = "CTRL",       action = wezterm.action.ActivateTab(2) },
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
