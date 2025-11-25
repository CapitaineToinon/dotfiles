return {
	"Mofiqul/vscode.nvim",
	priority = 1000,
	config = function()
		require("vscode").setup({})

		vim.cmd.colorscheme("vscode")
	end,
}

-- return {
-- 	"scottmckendry/cyberdream.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("cyberdream").setup({
-- 			variant = "light",
-- 			transparent = true,
-- 		})
-- 		vim.cmd.colorscheme("cyberdream")
-- 	end,
-- }
