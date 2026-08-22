local keymap = vim.keymap.set

vim.g.mapleader = " "

-- oil
keymap("n", "<leader>o", "<cmd>Oil<CR>")

-- lsp
keymap("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "[G]oto [D]efinition" })
keymap("n", "gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
keymap("n", "cr", vim.lsp.buf.rename, { desc = "Code: [C]ode [R]ename" })
keymap("n", "ca", vim.lsp.buf.code_action, { desc = "Code: [C]ode [A]ctions" })

-- conform
keymap("n", "<leader>cf", function()
	require("conform").format({ async = true })
end)

-- telescope
local builtin = require("telescope.builtin")
local working_tree_cache = {}

keymap("n", "<leader>f", function()
	local cwd = vim.fn.getcwd()

	if working_tree_cache[cwd] == nil then
		vim.fn.system("git rev-parse --is-inside-work-tree")
		working_tree_cache[cwd] = vim.v.shell_error == 0
	end

	if working_tree_cache[cwd] then
		require("telescope.builtin").git_files({
			use_git_root = false,
			show_untracked = true,
		})
	else
		require("telescope.builtin").find_files()
	end
end, { desc = "Telescope find files" })

keymap("n", "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })
keymap("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
keymap("n", "<leader>s", builtin.lsp_document_symbols, { desc = "Telescope symbols" })

-- harpoon
local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<leader>p", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<M-1>", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<M-2>", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<M-3>", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<M-4>", function()
	harpoon:list():select(4)
end)

-- lazygit
keymap("n", "<leader>lg", "<cmd>LazyGit<CR>")

-- tree-sitter manager
keymap("n", "<leader>tsm", "<cmd>TSManager<CR>")
