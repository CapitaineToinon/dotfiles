-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

require("plugins")
require("configs")
require("keymaps")
require("autocmds")
require("lsp")
