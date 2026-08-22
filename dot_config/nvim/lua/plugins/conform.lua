vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
	format_on_save = {
		-- These options will be passed to conform.format()
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		blade = { "blade-formatter" },
		svelte = { "prettier" },
		typescript = { "prettier" },
		javascript = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
	},
})
