local keymap = vim.keymap.set

vim.g.mapleader = " "

-- oil
keymap("n", "<leader>o", "<cmd>Oil<CR>", { desc = "File Explorer ([O]il)" })

-- lsp
keymap("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "[G]oto [D]efinition" })
keymap("n", "gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
keymap("n", "cr", vim.lsp.buf.rename, { desc = "Code: [C]ode [R]ename" })
keymap("n", "ca", vim.lsp.buf.code_action, { desc = "Code: [C]ode [A]ctions" })

-- conform
keymap("n", "<leader>cf", function()
	require("conform").format({ async = true })
end, { desc = "[C]onform [F]ormat" })

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
end, { desc = "Telescope Find [F]iles" })

keymap("n", "<leader>g", builtin.live_grep, { desc = "Telescope Live [G]rep" })
keymap("n", "<leader>b", builtin.buffers, { desc = "Telescope [B]uffers" })
keymap("n", "<leader>s", builtin.lsp_document_symbols, { desc = "Telescope [S]ymbols" })

-- lazygit
keymap("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "[L]azy [G]it" })

-- tree-sitter manager
keymap("n", "<leader>tsm", "<cmd>TSManager<CR>", { desc = "[T]ree-[S]itter [M]anager" })
