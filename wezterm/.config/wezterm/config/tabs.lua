local wezterm = require 'wezterm'
local M = {}

local color_scheme = require 'colors.cyber-purple'
local tab_colors = color_scheme.colors

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_left_half_circle_thick
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_right_half_circle_thick
local LEFT_SEPARATOR = "" -- U+E0B8
local RIGHT_SEPARATOR = "" -- U+E0BA


local process_icons = {
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["btm"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["curl"] = wezterm.nerdfonts.mdi_flattr,
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["git"] = wezterm.nerdfonts.fa_git,
	["go"] = wezterm.nerdfonts.seti_go,
	["htop"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["kubectl"] = wezterm.nerdfonts.linux_docker,
	["kuberlr"] = wezterm.nerdfonts.linux_docker,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["lazygit"] = wezterm.nerdfonts.oct_git_compare,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["node"] = wezterm.nerdfonts.mdi_hexagon,
	["nvim"] = wezterm.nerdfonts.custom_vim,
	["psql"] = "󱤢",
	["ruby"] = wezterm.nerdfonts.cod_ruby,
	["stern"] = wezterm.nerdfonts.linux_docker,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["usql"] = "󱤢",
	["vim"] = wezterm.nerdfonts.dev_vim,
	["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
}

-- Return the Tab's current working directory
local function get_cwd(tab)
	return tab.active_pane.current_working_dir and tab.active_pane.current_working_dir.file_path or ""
end

-- Remove all path components and return only the last value
local function remove_abs_path(path)
	path = path:gsub("[/\\]+$", "")
	return path:match("([^/\\]+)$") or ""
end

-- Return the pretty path of the tab's current working directory
local function get_display_cwd(tab)
	local current_dir = get_cwd(tab)
	local HOME_DIR = os.getenv("HOME")
	return current_dir == HOME_DIR and "~/" or remove_abs_path(current_dir)
end

-- Return the concise name or icon of the running process for display
local function get_process(tab)
	if not tab.active_pane or tab.active_pane.foreground_process_name == "" then return "[?]" end

	local process_name = remove_abs_path(tab.active_pane.foreground_process_name)
	if process_name:find("kubectl") then process_name = "kubectl" end

	return process_icons[process_name] or string.format("[%s]", process_name)
end

-- Pretty format the tab title
local function format_title(tab)
	local cwd = get_display_cwd(tab)
	local process = get_process(tab)

	local active_title = tab.active_pane.title
	if active_title:find("- NVIM") then active_title = active_title:gsub("^([^ ]+) .*", "%1") end

	local description = (not active_title or active_title == cwd) and "~" or active_title
	return string.format(" %s %s/ %s ", process, cwd, description)
end

-- Determine if a tab has unseen output since last visited
local function has_unseen_output(tab)
	if not tab.is_active then
		for _, pane in ipairs(tab.panes) do
			if pane.has_unseen_output then return true end
		end
	end
	return false
end

-- Returns manually set title (from `tab:set_title()` or `wezterm cli set-tab-title`) or creates a new one
local function get_tab_title(tab)
	local title = tab.tab_title
	if title and #title > 0 then return title end
	return format_title(tab)
end


function M.apply(config)
	config.enable_tab_bar = true
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = false
	config.hide_tab_bar_if_only_one_tab = false
	config.show_new_tab_button_in_tab_bar = false
	config.colors = config.colors or {}
	config.colors.tab_bar = tab_colors.tab_bar

	wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
		local is_active = tab.is_active
		local title = get_tab_title(tab)
		local bg = tab_colors.tab_title.bg
		local fg = is_active and tab_colors.tab_title.fg_active or tab_colors.tab_title.fg_inactive

		if has_unseen_output(tab) and not is_active then
			fg = '#EBD168'
		end

		local tab_bar_bg = tab_colors.tab_bar.background
		title = wezterm.truncate_right(title, max_width - 4)

		return {
			-- LEFT SEPARATOR:
			{ Background = { Color = tab_bar_bg } },
			{ Foreground = { Color = bg } },
			{ Text = RIGHT_SEPARATOR },

			-- TAB TITLE
			{ Background = { Color = bg } },
			{ Foreground = { Color = fg } },
			{ Text = ' ' .. title .. ' ' },

			-- RIGHT SEPARATOR:
			{ Background = { Color = bg } },
			{ Foreground = { Color = tab_bar_bg } },
			{ Text = RIGHT_SEPARATOR },

		}
	end)
end

return M
