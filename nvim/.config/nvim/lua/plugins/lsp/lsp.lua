return {
	-- LSP Plugins
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim",       opts = {} },
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- === Define Diagnostic Signs ===
			-- Custom signs should be defined separately from vim.diagnostic.config
			local signs = vim.g.have_nerd_font and {
				Error = "󰅙 ",
				Warn = "󰀦 ",
				Hint = "󰌶 ",
				Info = "󰋽 ",
			} or {
				Error = "✗ ",
				Warn = "‼ ",
				Hint = "ℹ ",
				Info = "i ",
			}
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- === Diagnostic Configuration ===
			vim.diagnostic.config({
				severity_sort = true,
				float = {
					border = "rounded",
					source = "if_many",
					header = "",
					prefix = " ",
					max_width = 80,
				},
				underline = false,
				signs = true,
				virtual_text = {
					severity = { min = vim.diagnostic.severity.ERROR },
					spacing = 4,
					prefix = "› ",
				},
			})

			-- Global diagnostic keymaps (outside of config)
			vim.keymap.set("n", "<leader>er", vim.diagnostic.open_float, { desc = "Show diagnostic float" })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

			-- === Helper: Check if client supports a method ===
			local function client_supports_method(client, method, bufnr)
				if vim.fn.has("nvim-0.11") == 1 then
					return client:supports_method(method, bufnr)
				else
					return client.supports_method(method, { bufnr = bufnr })
				end
			end

			-- === LSP Attach Autocmd ===
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local bufnr = event.buf
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if not client then return end

					-- Keymap helper scoped to buffer
					local function buf_map(mode, keys, func, desc)
						vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
					end

					-- Telescope LSP mappings
					buf_map("n", "gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					buf_map("n", "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					buf_map("n", "gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					buf_map("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					buf_map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					buf_map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols")

					-- Core LSP actions
					buf_map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					buf_map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					buf_map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					buf_map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
					buf_map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Signature Help")

					-- Formatting
					if client_supports_method(client, vim.lsp.protocol.Methods.textDocument_formatting, bufnr) then
						buf_map("n", "<leader>cf", function()
							vim.lsp.buf.format({ async = true })
						end, "[C]ode [F]ormat")
						-- Auto-format on save
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							group = vim.api.nvim_create_augroup("kickstart-lsp-format", { clear = false }),
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end

					-- Document Highlight
					if client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, bufnr) then
						local hl_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = bufnr,
							group = hl_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = bufnr,
							group = hl_augroup,
							callback = vim.lsp.buf.clear_references,
						})
					end

					-- Inlay Hints Toggle
					if client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
						-- Enable inlay hints by default if supported
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
						buf_map("n", "<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
								{ bufnr = bufnr })
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Global LspDetach for cleanup
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(ev)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = ev.buf })
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-format", buffer = ev.buf })
				end,
			})

			-- === Capabilities (for cmp + LSP) ===
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			-- === LSP Server Configurations ===
			local servers = {
				clangd = {},
				pylsp = {
					filetypes = { "python" },
					settings = {
						pylsp = {
							plugins = {
								pycodestyle = { enabled = true, maxLineLength = 120 },
								pyflakes = { enabled = false },
								mccabe = { enabled = false },
								rope_autoimport = { enabled = true },
								rope_completion = { enabled = true },
								jedi_completion = { fuzzy = true },
							},
						},
					},
				},
				verible = {
					cmd = { "verible-verilog-ls" },
					filetypes = { "verilog", "systemverilog" },
					root_dir = function(fname)
						return require("lspconfig.util").root_pattern(".git", ".svn", ".hg")(fname)
							or require("lspconfig.util").path.dirname(fname)
					end,
					single_file_support = true,
					settings = {
						verible = {
							linter = "on",
							formatter = "on",
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							format = {
								enable = true,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
								},
							},
							diagnostics = { disable = { "missing-fields" } },
							workspace = {
								checkThirdParty = false,
							},
							telemetry = { enable = false },
						},
					},
				},
			}

			-- === Tool & LSP Installation ===
			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, { "stylua" })
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {}, -- Handled by mason-tool-installer
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
