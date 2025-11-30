return {
	{
		"stevearc/oil.nvim",
		dependencies = {
			{
				"echasnovski/mini.icons",
				opts = {},
			},
		},
		keys = {
			{
				"<leader>o",
				"<CMD>Oil<CR>",
				desc = "Open file explorer",
			},
		},
		lazy = false,
		priority = 5000,
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
			},
		},
	},
}
