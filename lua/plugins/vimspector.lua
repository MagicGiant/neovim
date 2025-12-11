vim.cmd("nnoremap<Leader>de :call vimspector#Reset()<CR>")

vim.cmd("nnoremap<Leader>dd :call vimspector#Launch()<CR>")
vim.cmd("nnoremap<Leader>dc :call vimspector#Continue()<CR>")
vim.cmd("nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>")
vim.cmd("nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>")
vim.cmd("nmap <Leader>dk <Plug>VimspectorRestart")
vim.cmd("nmap <Leader>dh <Plug>VimspectorStepOut")
vim.cmd("nmap <Leader>dl <Plug>VimspectorStepInto")
vim.cmd("nmap <Leader>dj <Plug>VimspectorStepOver")

vim.api.nvim_create_user_command("Nspec", function(opts)
	local lang = opts.fargs[1]
	local config_dir = vim.fn.stdpath("config") .. "/lua/spec-configs/"
	local source_file = config_dir .. lang .. "/.vimspector.json"
	local target_dir = vim.fn.getcwd()
	local target_file = target_dir .. "/.vimspector.json"

	if vim.fn.filereadable(source_file) == 0 then
		vim.notify(
			"Файл конфигурации для " .. lang .. " не найден: " .. source_file,
			vim.log.levels.ERROR
		)
		return
	end

	local content = vim.fn.readfile(source_file)
	vim.fn.writefile(content, target_file)

	vim.notify(
		"Конфигурация для " .. lang .. " скопирована в " .. target_file,
		vim.log.levels.INFO
	)
end, {
	nargs = 1,
	complete = function(ArgLead, CmdLine, CursorPos)
		local config_dir = vim.fn.stdpath("config") .. "/lua/spec-configs/"
		local dirs = {}

		if vim.fn.isdirectory(config_dir) == 1 then
			local files = vim.fn.readdir(config_dir)
			for _, file in ipairs(files) do
				if vim.fn.isdirectory(config_dir .. file) == 1 then
					table.insert(dirs, file)
				end
			end
		end

		return dirs
	end,
	desc = "Копирует .vimspector.json для указанного языка в текущую директорию",
})
