---@type vim.lsp.Config
return {
	settings = {
		intelephense = {
			files = {
				exclude = {
					"**/.git/**",
					"**/node_modules/**",
					"**/vendor/**/{Tests,tests}/**",
					-- optionally full vendor if stubs cover everything:
					-- "**/vendor/**",
				},
			},
			stubs = {
				"Core",
				"standard",
				"pcre",
				"date",
				"SPL",
				"pdo",
				"mbstring",
				"hash",
				"openssl",
				"curl",
				"session",
				"tokenizer",
				"xml",
				"fileinfo",
				"filter",
				"imagick",
			},
		},
	},
}
