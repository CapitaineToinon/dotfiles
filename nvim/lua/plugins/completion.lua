return {
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = "rafamadriz/friendly-snippets",

		-- use a release tag to download pre-built binaries
		version = "*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = { preset = "default" },

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			fuzzy = {
				sorts = {
					function(a, b)
						local types = require("blink.cmp.types").CompletionItemKind

						-- Put Radix UI suggestions at the bottom
						-- Only applies to the `vtsls` client (TypeScript/JavaScript)
						-- and only applies to variable suggestions
						if
							a.client_name ~= "vtsls"
							or b.client_name ~= "vtsls"
							or a.kind ~= types.Variable
							or b.kind ~= types.Variable
							or a.labelDetails == nil
							or b.labelDetails == nil
							or a.labelDetails.description == nil
							or b.labelDetails.description == nil
						then
							return
						end

						if
							a.label == b.label
							and a.labelDetails.description:find("@radix%-ui/")
								~= b.labelDetails.description:find("@radix%-ui/")
						then
							return a.labelDetails.description:find("@radix%-ui/") == nil
						end
					end,
					-- default sorts
					"score",
					"sort_text",
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
