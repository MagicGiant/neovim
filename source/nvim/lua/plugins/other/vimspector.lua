local function config()
	vim.cmd("nnoremap<Leader>de :call vimspector#Reset()<CR>")

	vim.cmd("nnoremap<Leader>dd :call vimspector#Launch()<CR>")
	vim.cmd("nnoremap<Leader>dc :call vimspector#Continue()<CR>")
	vim.cmd("nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>")
	vim.cmd("nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>")
	vim.cmd("nmap <Leader>dk <Plug>VimspectorRestart")
	vim.cmd("nmap <Leader>dh <Plug>VimspectorStepOut")
	vim.cmd("nmap <Leader>dl <Plug>VimspectorStepInto")
	vim.cmd("nmap <Leader>dj <Plug>VimspectorStepOver")
end

return {
	"puremourning/vimspector",
	config = config,
}
