require("neogen").setup({ { snippet_engine = "vsnip" } })

vim.api.nvim_set_keymap("n", "gn", ":Neogen<CR>", { noremap = true, silent = true })
