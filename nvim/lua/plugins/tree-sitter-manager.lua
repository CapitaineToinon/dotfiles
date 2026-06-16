vim.pack.add({
	{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },
})

-- vim.filetype.add({
-- 	pattern = {
-- 		[".*%.blade%.php"] = "blade",
-- 	},
-- })

require("tree-sitter-manager").setup({
	auto_install = true,
	ensure_installed = {
		"blade",
		"html",
		"html_tags",
		"php",
		"php_only",
		"lua",
	},
})
