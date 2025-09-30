local map = vim.api.nvim_buf_set_keymap
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Autocommand group for file execution
local run_group = augroup("RunOnSave", { clear = true })

-- Filetype to command mapping
local run_commands = {
	javascript = "node",
	cpp = "g++ % -o %:r && ./%:r",
	c = "gcc % -o %:r && ./%:r",
	lua = "lua",
	python = "python3",
}

-- Set up keymaps for running files based on filetype
for filetype, cmd in pairs(run_commands) do
	autocmd("FileType", {
		group = run_group,
		pattern = filetype,
		callback = function()
			map(0, "n", "<leader>r", string.format(":w<CR>:split term://%s %%<CR>:resize 10<CR>", cmd), {
				desc = string.format("Run %s file", filetype),
				noremap = true,
				silent = true,
			})
		end,
	})
end

-- Restore cursor on exit
autocmd("ExitPre", {
	group = augroup("Exit", { clear = true }),
	command = "set guicursor=a:ver25",
	desc = "Restore cursor to beam on Neovim exit",
})

-- Markdown-specific options
autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.wrap = false
		vim.opt_local.linebreak = true
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end,
	desc = "Configure Markdown settings",
})

-- Disable auto-commenting for all filetypes
autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
	desc = "Disable auto-commenting on new lines",
})

-- Cursor visibility for SnacksDashboard
local function set_cursor_visibility(event, blend)
	autocmd("User", {
		pattern = "SnacksDashboard" .. event,
		callback = function()
			local hl = vim.api.nvim_get_hl(0, { name = "Cursor", create = true })
			hl.blend = blend
			vim.api.nvim_set_hl(0, "Cursor", hl)
			vim.opt.guicursor:append("a:Cursor/lCursor")
		end,
		desc = string.format("Set cursor visibility for SnacksDashboard%s", event),
	})
end

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
	group = 'YankHighlight',
	callback = function()
		vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
	end
})

-- Remove whitespace on save
autocmd('BufWritePre', {
	pattern = '*',
	command = ":%s/\\s\\+$//e"
})

-- Format options for specific filetypes
augroup('FormatOptions', { clear = true })
autocmd('FileType', {
	group = 'FormatOptions',
	pattern = { 'c', 'cpp', 'java', 'javascript', 'lua', 'python', 'rust', 'typescript' },
	command = 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
})

set_cursor_visibility("Opened", 100)
set_cursor_visibility("Closed", 0)
