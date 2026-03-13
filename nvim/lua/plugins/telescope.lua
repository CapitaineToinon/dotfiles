local working_tree_cache = {}

return {
	"nvim-telescope/telescope.nvim",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	opts = {
		pickers = {
			colorscheme = {
				enable_preview = true,
			},
		},
	},
	keys = {
		{
			"<leader>f",
			function()
				local cwd = vim.fn.getcwd()

				if working_tree_cache[cwd] == nil then
					vim.fn.system("git rev-parse --is-inside-work-tree")
					working_tree_cache[cwd] = vim.v.shell_error == 0
				end

				if working_tree_cache[cwd] then
					require("telescope.builtin").git_files({
						use_git_root = false,
						show_untracked = true,
					})
				else
					require("telescope.builtin").find_files()
				end
			end,
			desc = "Telescope find files",
		},
		{
			"<leader>g",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Telescope find files",
		},
		{
			"<leader>s",
			function()
				require("telescope.builtin").lsp_document_symbols()
			end,
			desc = "Telescope find symbols",
		},
		{
			"<leader>T",
			function()
				require("telescope.builtin").colorscheme()
			end,
			desc = "Telescope find themes",
		},
		{
			"<leader>b",
			function()
				require("telescope.builtin").buffers({
					sort_lastused = true,
				})
			end,
			desc = "Telescipe find buffers",
		},
		{
			"<leader>en",
			function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end,
			desc = "Telescope find config files",
		},
		{
			"<leader>h",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "Telescope find help",
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)

		require("telescope").load_extension("fzf")
	end,
}
