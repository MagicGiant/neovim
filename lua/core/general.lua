

-- табы
vim.opt.tabstop = 2        -- количество пробелов для отображения таба
vim.opt.shiftwidth = 2     -- количество пробелов для автоотступов
vim.opt.softtabstop = 2    -- количество пробелов при редактировании


-- нумерация
vim.wo.number = true
vim.wo.relativenumber = true


-- Автосохранение при изменении текста
vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
  pattern = "*",
	command= "silent! wa"
})


-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true



-- всякое
vim.opt.clipboard = "unnamedplus" -- системный буффер обмена для "y"
-- vim.g.formatoptions = "grn1"
vim.opt.updatetime = 100 -- Устанавливает задержку в миллисекундах перед записью в swap файл и триггерами CursorHold
vim.wo.signcolumn = "yes" -- Всегда показывает колонку знаков (слева от номеров строк)
vim.opt.scrolloff = 12 --  Количество строк которые остаются видимыми над/под курсором при прокрутке. Создает "буферную зону" чтобы курсор не упирался в край экрана.
vim.opt.wrap = true -- Включает перенос длинных строк
vim.wo.linebreak = true -- Включает интеллектуальный перенос строк только в местах где это не ломает слова (например, после пробелов)
vim.opt.undofile = true -- Сохраняет историю изменений в файл, позволяя отменять действия даже после перезапуска NeoVim. Файлы хранятся в ~/.local/state/nvim/undo/
