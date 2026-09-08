-- file-info.lua
local M = {}

-- Функция для получения информации о файле
function M.get_file_info()
	local bufnr = vim.api.nvim_get_current_buf()

	-- Получаем путь
	local full_path = vim.api.nvim_buf_get_name(bufnr)
	local file_name = vim.fn.fnamemodify(full_path, ":t")
	local file_dir = vim.fn.fnamemodify(full_path, ":h")
	local file_extension = vim.fn.fnamemodify(full_path, ":e")

	-- Получаем информацию о буфере
	local ft = vim.bo[bufnr].filetype
	if ft == "" then
		ft = "unknown"
	end

	local fileformat = vim.bo[bufnr].fileformat
	local encoding = vim.bo[bufnr].fileencoding
	if encoding == "" then
		encoding = vim.bo[bufnr].encoding
	end

	-- Размер файла
	local file_size = 0
	if full_path ~= "" then
		local stat = vim.uv.fs_stat(full_path)
		if stat then
			file_size = stat.size
		end
	end

	-- Строки
	local line_count = vim.api.nvim_buf_line_count(bufnr)

	-- Модификация
	local modified = vim.bo[bufnr].modified and "Да" or "Нет"
	local readonly = vim.bo[bufnr].readonly and "Да" or "Нет"

	-- Форматируем размер
	local function format_size(bytes)
		if bytes < 1024 then
			return bytes .. " B"
		elseif bytes < 1024 * 1024 then
			return string.format("%.2f KB", bytes / 1024)
		else
			return string.format("%.2f MB", bytes / (1024 * 1024))
		end
	end

	return {
		name = file_name,
		path = full_path,
		dir = file_dir,
		extension = file_extension,
		filetype = ft,
		fileformat = fileformat,
		encoding = encoding,
		size = format_size(file_size),
		lines = line_count,
		modified = modified,
		readonly = readonly,
		-- Дополнительная информация
		buftype = vim.bo[bufnr].buftype,
		bufhidden = vim.bo[bufnr].bufhidden,
	}
end

-- Функция для создания плавающего окна
function M.show_file_info()
	local info = M.get_file_info()

	-- Данные для окна: метка и значение (две колонки)
	local groups = {
		{
			{ "Файл", info.name },
			{ "Путь", info.path },
			{ "Директория", info.dir },
		},
		{
			{ "Тип", info.filetype },
			{ "Расширение", info.extension },
			{ "Формат", info.fileformat },
			{ "Кодировка", info.encoding },
		},
		{
			{ "Строк", info.lines },
			{ "Размер", info.size },
		},
		{
			{ "Изменён", info.modified },
			{ "Только чтение", info.readonly },
		},
		{
			{ "Тип буфера", info.buftype },
			{ "Поведение", info.bufhidden },
		},
	}

	-- Максимальная ширина меток (в знакоместах)
	local label_w = 0
	for _, group in ipairs(groups) do
		for _, row in ipairs(group) do
			label_w = math.max(label_w, vim.fn.strwidth(row[1]))
		end
	end

	-- Выравниваем значения по одной колонке, между группами пустая строка
	local lines = { info.name, "" }
	for gi, group in ipairs(groups) do
		if gi > 1 then
			lines[#lines + 1] = ""
		end
		for _, row in ipairs(group) do
			local pad = string.rep(" ", label_w - vim.fn.strwidth(row[1]) + 2)
			lines[#lines + 1] = row[1] .. pad .. row[2]
		end
	end

	-- Ширина окна по самой длинной строке (минимум 60 знакомест)
	local max_line = 0
	for _, l in ipairs(lines) do
		max_line = math.max(max_line, vim.fn.strwidth(l))
	end
	local width = math.max(60, max_line + 4)
	local height = #lines + 2

	local opts = {
		relative = "editor",
		row = math.floor((vim.o.lines - height) / 2) - 2,
		col = math.floor((vim.o.columns - width) / 2),
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
		title = " Информация о файле ",
		title_pos = "center",
	}

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- Настраиваем буфер (только для чтения, не изменяемый)
	vim.bo[buf].filetype = "markdown"
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].modifiable = false
	vim.bo[buf].readonly = true

	-- Создаем окно: enter=true — фокус сразу передаётся окну
	local win = vim.api.nvim_open_win(buf, true, opts)

	-- Прозрачный фон окна (переопределяем группы только для этого окна)
	local hl_ns = vim.api.nvim_create_namespace("FileInfoFloat")
	vim.api.nvim_set_hl(hl_ns, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(hl_ns, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(hl_ns, "FloatBorder", { bg = "none" })
	vim.api.nvim_set_hl(hl_ns, "FloatTitle", { bg = "none" })
	vim.api.nvim_win_set_hl_ns(win, hl_ns)

	-- Закрытие по ESC, q или Enter (фокус уже на окне)
	local function close_on_key()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
		if vim.api.nvim_buf_is_valid(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
		vim.cmd("stopinsert")
	end

	vim.keymap.set("n", "q", close_on_key, { buffer = buf, nowait = true })
	vim.keymap.set("n", "<Esc>", close_on_key, { buffer = buf, nowait = true })
	vim.keymap.set("n", "<CR>", close_on_key, { buffer = buf, nowait = true })

	-- Автозакрытие при потере фокуса окном (если переключиться на другое окно)
	vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
		buffer = buf,
		callback = function()
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
			if vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end,
	})
end

-- Создаем команду и хоткей
vim.api.nvim_create_user_command("FileInfo", M.show_file_info, {})

-- Назначаем на Ctrl+G (можно изменить на любую другую комбинацию)
vim.keymap.set("n", "<C-g>", M.show_file_info, { desc = "Показать информацию о файле" })

return M
