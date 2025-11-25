-- configs

-- enable
vim.lsp.enable('lua_ls')
require('lspconfig').lua_ls.setup({
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace"
			}
		}
	}
})

vim.lsp.enable('ts_ls', {
	root_markers = { 'package-lock.json', 'package.json', '.git' }
})
vim.lsp.enable('ty')


-- diagnostic
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, { desc = "Show diagnostic" })
