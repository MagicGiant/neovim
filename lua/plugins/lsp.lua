-- configs

vim.lsp.config('ts_ls', {
	root_markers = { 'package.json', '.git' },
})

-- enable

vim.lsp.enable('lua_ls')
vim.lsp.enable('ts_ls', {
	root_markers = { 'package.json', '.git' }
})
vim.lsp.enable('ty')
