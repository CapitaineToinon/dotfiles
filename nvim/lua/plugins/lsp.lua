return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		opts = {
			ensure_installed = {
				"html",
				"lua_ls",
				"intelephense",
				"tailwindcss",
				"vtsls",
				"tinymist",
				--- right now, pyright is meant to be used alongside ruff
				"pyright",
				"ruff",
				"zls",
				"gopls",
			},
			servers = {
				lua_ls = {},
				intelephense = {},
				tailwindcss = {},
				svelte = {},
				vtsls = {
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = "/Users/user/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server",
								languages = { "vue" },
							},
						},
					},
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				},
				tinymist = {
					settings = {
						formatterMode = "typstyle",
					},
				},
				pyright = {
					settings = {
						pyright = {
							-- Using Ruff's import organizer
							disableOrganizeImports = true,
						},
						python = {
							analysis = {
								-- Ignore all files for analysis to exclusively use Ruff for linting
								ignore = { "*" },
							},
						},
					},
				},
				ruff = {},
				zls = {},
				rust_analyzer = {},
				gopls = {},
				sourcekit = {
					capabilities = {
						workspace = {
							didChangeWatchedFiles = {
								dynamicRegistration = true,
							},
						},
					},
				},
				astro = {},
				jdtls = {},
			},
		},
		config = function(_, opts)
			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_enable = false,
				ensure_installed = opts.ensure_installed,
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			for name, config in pairs(opts.servers) do
				config = vim.tbl_deep_extend("force", config, { capabilities = capabilities })
				lspconfig[name].setup(config)
			end
		end,
	},
}
