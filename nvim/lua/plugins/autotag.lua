return {
	"windwp/nvim-ts-autotag",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		aliases = {
			blade = "html",
		},
	},
}
