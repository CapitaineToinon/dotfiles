vim.pack.add({
	"nvim-lua/plenary.nvim",
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
})

local harpoon = require("harpoon")
local harpoon_extensions = require("harpoon.extensions")

harpoon.setup()
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
