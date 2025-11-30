return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"php",
				"php_only",
				"html",
				"css",
				"blade",
				"lua",
				"javascript",
				"typescript",
				"gleam",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			---@class ParserInfo[]
			local configs = require("nvim-treesitter.parsers").get_parser_configs()

			configs.blade = {
				install_info = {
					url = "https://github.com/EmranMR/tree-sitter-blade",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetype = "blade",
			}

			-- configs.blade = {
			-- 	install_info = {
			-- 		url = "https://github.com/deanrumsby/tree-sitter-blade",
			-- 		files = { "src/parser.c", "src/scanner.c" },
			-- 		branch = "main",
			-- 	},
			-- 	filetype = "blade",
			-- }
		end,
	},
}
