local colors = {
	neon_blue    = "#00f7ff", -- Bright cyan for primary accents
	neon_pink    = "#ff00ff", -- Vibrant magenta for highlights
	neon_green   = "#39ff14", -- Electric green for active elements
	neon_purple  = "#b300ff", -- Deep purple for secondary accents
	dark_cyan    = "#1a3c4d", -- Dark teal for backgrounds
	dark_grey    = "#0a0e14", -- Near-black for base background
	bright_white = "#e0e0ff", -- Slightly tinted white for text
	dim_grey     = "#2a2e38", -- Muted grey for inactive elements
	neon_red     = "#ff073a", -- Bright red for errors or terminal mode
}

-- Custom cyberpunk lualine theme
local cyberpunk = {
	normal = {
		a = {
			bg = colors.neon_blue,
			fg = colors.dark_grey,
			gui = "bold"
		},
		b = { bg = colors.dim_grey, fg = colors.bright_white, gui = "bold" },
		c = { bg = colors.dark_grey, fg = colors.neon_pink, gui = "italic" },
	},
	insert = {
		a = { bg = colors.neon_green, fg = colors.dark_grey, gui = "bold" },
		c = { bg = colors.dark_grey, fg = colors.neon_purple, gui = "italic" },
	},
	visual = {
		a = { bg = colors.neon_purple, fg = colors.dark_grey, gui = "bold" },
		c = { bg = colors.dark_grey, fg = colors.bright_white, gui = "italic" },
	},
	command = {
		a = { bg = colors.neon_pink, fg = colors.dark_grey, gui = "bold" },
		c = { bg = colors.dark_grey, fg = colors.bright_white, gui = "italic" },
	},
	terminal = {
		a = { bg = colors.neon_red, fg = colors.dark_grey, gui = "bold" },
		c = { bg = colors.dark_grey, fg = colors.bright_white, gui = "italic" },
	},
	replace = {
		a = { bg = colors.neon_blue, fg = colors.dark_grey, gui = "bold" },
		c = { bg = colors.dark_grey, fg = colors.neon_purple, gui = "italic" },
	},
	inactive = {
		a = { bg = colors.dim_grey, fg = colors.bright_white, gui = "bold" },
		c = { bg = colors.dark_grey, fg = colors.dim_grey, gui = "italic" },
	},
}

-- Buffer component configuration
local buffer_component = {
	"buffers",
	buffers_color = {
		active = { bg = colors.neon_green, fg = colors.dark_grey, gui = "bold" },
		inactive = { bg = colors.dim_grey, fg = colors.bright_white, gui = "italic" },
	},
	symbols = {
		modified = " ◉", -- Futuristic circle for modified buffers
		alternate_file = "",
		directory = "📂", -- Modern folder emoji
	},
	mode = 2,
}

-- Filename component configuration
local filename_component = {
	"filename",
	file_status = true,
	path = 3,
	shorting_target = 0,
	symbols = {
		modified = " ◉",
		readonly = " 🔒", -- Lock icon for cyberpunk vibe
		unnamed = "[No Name]",
	},
}

-- Plugin configuration
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {
		options = {
			theme = cyberpunk,
			component_separators = { left = "┃", right = "┃" }, -- Thicker, futuristic separator
			section_separators = { left = "", right = "" }, -- Angled, neon-like separators
			disabled_filetypes = { statusline = { "snacks_dashboard" } },
		},
		sections = {
			lualine_a = { { "mode", icon = "⚡️" } }, -- Cyberpunk lightning bolt
			lualine_b = { "branch", "diff", "diagnostics", buffer_component },
			lualine_c = { filename_component },
			lualine_x = { "filesize" },
			lualine_y = { "searchcount", "selectioncount", "encoding", "filetype" },
			lualine_z = { "progress", "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { filename_component },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	},
	config = function(_, opts)
		require("lualine").setup(opts)
		vim.opt.laststatus = 3
	end,
}
