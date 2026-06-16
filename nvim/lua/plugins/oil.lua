vim.pack.add({ 'https://github.com/nvim-mini/mini.icons' })
vim.pack.add({ 'https://github.com/stevearc/oil.nvim' })

require("mini.icons").setup()

require("oil").setup({
	default_file_explorer = true,
	view_options = {
		show_hidden = true,
	},
})
