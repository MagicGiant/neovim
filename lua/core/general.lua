vim.opt.clipboard = "unnamedplus" -- системный буффер обмена для "y"
vim.opt.tabstop = 2        -- количество пробелов для отображения таба
vim.opt.shiftwidth = 2     -- количество пробелов для автоотступов
vim.opt.softtabstop = 2    -- количество пробелов при редактировании

-- Автосохранение при изменении текста
vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
  pattern = "*",
	command= "silent! wa"
}
