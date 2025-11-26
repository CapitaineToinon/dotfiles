return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>p",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format Buffer (conform)",
			},
		},
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				php = { "pint" },
				python = {
					-- To fix auto-fixable lint errors.
					"ruff_fix",
					-- To run the Ruff formatter.
					"ruff_format",
					-- To organize the imports.
					"ruff_organize_imports",
				},
				blade = { "prettier" },
				css = { "prettier" },
				typescriptreact = { "prettier" },
				typst = { "tinymist" },
				json = { "prettier" },
				jsonc = { "prettier" },
				yaml = { "yamlfix" },
				vue = { "prettier" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = {
				timeout_ms = 500,
			},
		},
	},
}
