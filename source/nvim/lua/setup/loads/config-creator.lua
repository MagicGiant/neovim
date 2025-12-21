vim.api.nvim_create_user_command("Config", function(opts)
	local config_name = opts.fargs[1]
	local config_dir = vim.fn.stdpath("config") .. "/lua/configs/"
	local source_dir = config_dir .. config_name .. "/"
	local target_dir = vim.fn.getcwd()

	if vim.fn.isdirectory(source_dir) == 0 then
		vim.notify(
			"Конфигурация " .. config_name .. " не найдена: " .. source_dir,
			vim.log.levels.ERROR
		)
		return
	end

	local files = vim.fn.readdir(source_dir)

	for _, file in ipairs(files) do
		local source_file = source_dir .. file
		local target_file = target_dir .. "/" .. file

		if vim.fn.filereadable(source_file) == 1 then
			local content = vim.fn.readfile(source_file)
			vim.fn.writefile(content, target_file)
		end
	end

	vim.notify(
		"Все файлы конфигурации " .. config_name .. " скопированы в " .. target_dir,
		vim.log.levels.INFO
	)
end, {
	nargs = 1,
	complete = function(ArgLead, CmdLine, CursorPos)
		local config_dir = vim.fn.stdpath("config") .. "/lua/configs/"
		local configs = {}

		if vim.fn.isdirectory(config_dir) == 1 then
			local items = vim.fn.readdir(config_dir)
			for _, item in ipairs(items) do
				if vim.fn.isdirectory(config_dir .. item) == 1 then
					table.insert(configs, item)
				end
			end
		end

		return configs
	end,
	desc = "Копирует все файлы конфигурации с указанным именем в текущую директорию",
})
