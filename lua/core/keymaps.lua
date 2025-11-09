vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>e", "<Cmd>Neotree<CR>")
vim.keymap.set("n", "<leader>E", "<Cmd>Neotree close<CR>")

vim.api.nvim_set_keymap('n', '<C-q>', ':wqa<CR>', { noremap = true, silent = true })
