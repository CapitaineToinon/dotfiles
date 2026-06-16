local keymap = vim.keymap.set

vim.g.mapleader = " "

-- vim.pack
keymap("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>")

-- oil
keymap("n", "<leader>o", "<cmd>Oil<CR>")

-- conform
keymap("n", "<leader>p", function()
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

-- lazygit
keymap("n", "<leader>lg", "<cmd>LazyGit<CR>")

-- tree-sitter manager
keymap("n", "<leader>tsm", "<cmd>TSManager<CR>")
