vim = vim

vim.opt.fillchars = {
	vert = "▌",
	horiz = "▁",
}

-- #ОТКЛЮЧАЮ ПОДТВЕРЖДЕНИЕ ПРИ РАБОТЕ ЧЕРЕЗ СЕТЕВУЮ ПАПКУ
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- #ДИАГНОСТИКА

vim.diagnostic.config({
	virtual_text = {
		source = "if_many", -- Показывать источник ошибки, если диагностик много
		severity = {
			min = vim.diagnostic.severity.HINT, -- Показывать предупреждения и ошибки
		},
		format = function(diagnostic)
			local icons = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.INFO] = " ",
				[vim.diagnostic.severity.HINT] = "󰌶 ",
			}
			local icon = icons[diagnostic.severity] or ""
			return icon .. diagnostic.message
		end,
		-- Разместить текст справа
		prefix = "",
		suffix = " ",
	},
	underline = true, -- Подчёркивание проблемного кода
	signs = true, -- Значки на полях
	float = { -- Всплывающее окно по запросу
		-- 	border = "rounded",
		source = "always",
	},
})

-- #ТАБЫ
vim.opt.tabstop = 2 -- количество пробелов для отображения таба
vim.opt.shiftwidth = 2 -- количество пробелов для автоотступов
vim.opt.softtabstop = 2 -- количество пробелов при редактировании

-- #НУМЕРАЦИЯ
vim.wo.number = true
vim.wo.relativenumber = true

-- #АВТОСОХРАНЕНИЕ ПРИ ИЗМЕНЕНИИ ТЕКСТА

local autosave_aucmd_id = nil

local function autosave_on()
	if autosave_aucmd_id then
		vim.notify("Автосохранение уже включено")
		return false
	end

	autosave_aucmd_id = vim.api.nvim_create_autocmd({ "InsertLeave", "TextYankPost" }, {
		pattern = "*",
		command = "silent! wa",
	})

	return true
end

local function autosave_off()
	if not autosave_aucmd_id then
		vim.notify("Автосохранение уже выключено")
		return false
	end

	vim.api.nvim_del_autocmd(autosave_aucmd_id)
	autosave_aucmd_id = nil

	return true
end

vim.api.nvim_create_user_command("AutosaveOn", function()
	if autosave_on() then
		vim.notify("Автосохнанениe включено")
	end
end, {})

vim.api.nvim_create_user_command("AutosaveOff", function()
	if autosave_off() then
		vim.notify("Автосохранение выключено")
	end
end, {})

-- autosave_on()
-- #МЫШКА

local function mouse_on()
	vim.opt.mouse = "a"
	vim.opt.mousefocus = true
end

local function mouse_off()
	vim.opt.mouse = ""
	vim.opt.mousefocus = false
end

vim.api.nvim_create_user_command("MouseOn", function()
	mouse_on()
	vim.notify("Взаимодействие с мышкой включено")
end, {})

vim.api.nvim_create_user_command("MouseOff", function()
	mouse_off()
	vim.notify("Взаимодействие с мышкой выключено")
end, {})

mouse_off()

-- #ВСЯКОЕ
vim.opt.clipboard = "unnamedplus" -- системный буффер обмена для "y"
-- vim.g.formatoptions = "grn1"
vim.opt.updatetime = 100 -- Устанавливает задержку в миллисекундах перед записью в swap файл и триггерами CursorHold
vim.wo.signcolumn = "yes" -- Всегда показывает колонку знаков (слева от номеров строк)
vim.opt.scrolloff = 12 --  Количество строк которые остаются видимыми над/под курсором при прокрутке. Создает "буферную зону" чтобы курсор не упирался в край экрана.
vim.opt.wrap = true -- Включает перенос длинных строк
vim.wo.linebreak = true -- Включает интеллектуальный перенос строк только в местах где это не ломает слова (например, после пробелов)
vim.opt.undofile = true -- Сохраняет историю изменений в файл, позволяя отменять действия даже после перезапуска NeoVim. Файлы хранятся в ~/.local/state/nvim/undo/

vim.api.nvim_create_user_command("Ontab", function()
	local file_path = vim.fn.expand("%:p")
	vim.cmd("bd")
	vim.cmd("edit " .. file_path)
end, {})

vim.api.nvim_create_user_command("CopyPath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.jobstart('echo "' .. path .. '" | wl-copy', {
		on_exit = function()
			vim.notify("Путь скопирован: " .. path)
		end,
	})
end, {})

--- filetypes

vim.filetype.add({
	extension = {
		handlebars = "html.handlebars",
		ejs = "html",
	},
})
