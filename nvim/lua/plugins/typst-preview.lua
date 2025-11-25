return {
	{
		"chomosuke/typst-preview.nvim",
		lazy = false, -- or ft = 'typst'
		version = "1.*",
		opts = {
			invert_colors = "auto",
			dependencies_bin = {
				["tinymist"] = "tinymist",
			},
		}, -- lazy.nvim will implicitly calls `setup {}`
	},
}
