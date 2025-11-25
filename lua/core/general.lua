-- отключаю подтверждение при работе через сетевую папку

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

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

vim.api.nvim_create_user_command('Ontab', function()
    local file_path = vim.fn.expand('%:p')
    vim.cmd('bd')
    vim.cmd('edit ' .. file_path)
end, {})

vim.api.nvim_create_user_command('CopyPath', function()
    local path = vim.fn.expand('%:p')
    vim.fn.jobstart('echo "' .. path .. '" | wl-copy', {
        on_exit = function()
            print('Путь скопирован: ' .. path)
        end
    })
end, {})
