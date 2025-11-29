return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			auto_integrations = false,
			integrations = {
				telescope = {
					enabled = true,
				}
			}
		})

		vim.cmd("colorscheme catppuccin")
	end,
}
