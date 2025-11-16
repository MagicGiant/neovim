vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>e", "<Cmd>Neotree<CR>")
vim.keymap.set("n", "<leader>E", "<Cmd>Neotree close<CR>")

vim.api.nvim_set_keymap('n', '<C-q>', ':wqa<CR>', { noremap = true, silent = true })

-- buffer line
vim.keymap.set("n", "<C-A-h>", "<Cmd>BufferLineMovePrev<CR>")
vim.keymap.set("n", "<C-A-l>", "<Cmd>BufferLineMoveNext<CR>")

vim.keymap.set("n", "<C-h>", "<Cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<C-l>", "<Cmd>BufferLineCycleNext<CR>")

local closeWindows = "<Cmd>bd<CR>"
vim.keymap.set("n", "<C-b>ct", closeWindows)
vim.keymap.set("n", "<C-A-d>", closeWindows)
vim.keymap.set("n", "<C-b>ch", "<Cmd>BufferLineCloseLeft<CR>")
vim.keymap.set("n", "<C-b>cl", "<Cmd>BufferLineCloseRight<CR>")
vim.keymap.set("n", "<C-b>co", "<Cmd>BufferLineCloseOthers<CR>")
vim.keymap.set("n", "<C-b>p", "<Cmd>BufferLinePick<CR>")

