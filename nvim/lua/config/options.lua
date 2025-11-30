vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- global config stuff
local opt = vim.opt

opt.number = true             -- show numbers
opt.mouse = "a"               -- enable mouse mode
opt.tabstop = 4               -- how big tabs should be
opt.termguicolors = true      -- true colors
opt.showmode = false          -- already shown in the statusline
opt.relativenumber = true     -- show relative line numbers
opt.clipboard = "unnamedplus" -- use system clipboard

-- lsp stuff
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local set = vim.keymap.set
		local map = function(keys, func, desc)
			set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

		set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Code: [C]ode [R]ename" })
		set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code: [C]ode [A]ctions" })
	end,
})

vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
		[".*%.antlers%.php"] = "antlers",
		[".env..*%"] = "dotenv",
	},
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
