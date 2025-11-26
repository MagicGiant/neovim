require("ale").setup({})

local g = vim.g

g.ale_linters = {
	lua = { "lua_language_server" },
	javascript = { "biome" },
}

g.ale_fixers = {
	javascript = { "biome" },
	lua = { "stylua" },
}

vim.cmd(":ALEDisable")

vim.api.nvim_set_keymap("n", "<leader>l", ":ALEEnable<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>L", ":ALEDisable<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>f", ":ALEFix<CR>", { noremap = true, silent = true })
