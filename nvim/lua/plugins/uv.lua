vim.pack.add({
	{ src = "https://github.com/benomahony/uv.nvim" },
})

require("uv").setup({ pick_integration = true })
