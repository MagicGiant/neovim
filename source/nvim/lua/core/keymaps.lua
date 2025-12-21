vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.api.nvim_set_keymap("n", "<C-q>", ":wqa<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-s>", ":wa<CR>", { noremap = true, silent = true })

-- # РАБОТА С ОКНАМИ

-- размеры
local changeValue = 10
vim.cmd("nnoremap <A-L> 10<C-w>>")
vim.cmd("nnoremap <A-H> 10<C-w><")
vim.cmd("nnoremap <A-J> 10<C-w>-")
vim.cmd("nnoremap <A-K> 10<C-w>+")

-- создание
vim.cmd("nnoremap <A-v> <C-w>v")
vim.cmd("nnoremap <A-s> <C-w>s")

-- удаление
vim.cmd("nnoremap <A-d> <C-w>c")

-- переключение

vim.cmd("nnoremap <A-h> <C-w>h")
vim.cmd("nnoremap <A-j> <C-w>j")
vim.cmd("nnoremap <A-k> <C-w>k")
vim.cmd("nnoremap <A-l> <C-w>l")
