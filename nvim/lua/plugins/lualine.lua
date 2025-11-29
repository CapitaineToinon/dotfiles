return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
		config = function()
			local catppuccin = require('catppuccin.utils.lualine')

			require('lualine').setup({
				options = {
					theme = catppuccin('mocha'),
					component_separators = "",
					section_separators = { left = "", right = "" },
				},
			})
		end
	}
}
