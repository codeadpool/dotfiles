return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	version = '1.*',
	opts = {
		keymap = {
			preset = "enter",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<CR>"] = { "accept", "fallback" },
			["<C-j>"] = { "snippet_forward", "fallback" },
			["<C-k>"] = { "snippet_backward", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
		},
		sources = {
			providers = {
				lsp = { score_offset = 2 },
				path = { score_offset = 1 },
				snippets = { score_offset = 0 },
				buffer = { score_offset = -1 },
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 3 },
			},
		},
	},
}
