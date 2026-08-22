local opt = vim.opt

opt.number = true -- show numbers
opt.mouse = "a" -- enable mouse mode
opt.tabstop = 4 -- how big tabs should be
opt.termguicolors = true -- true colors
opt.showmode = false -- already shown in the statusline
opt.relativenumber = true -- show relative line numbers
opt.clipboard = "unnamedplus" -- use system clipboard

vim.cmd.colorscheme("catppuccin")
