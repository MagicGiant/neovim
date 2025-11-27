local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "biome" },
	},
})

local autosave_autocmd_id = nil

local function autosaveOn()
	if autosave_autocmd_id then
		vim.notify("Автоматическое форматирование уже включено")
		return false
	end
	autosave_autocmd_id = vim.api.nvim_create_autocmd("BufWritePre", {
		callback = function(args)
			conform.format({ bufnr = args.buf })
		end,
	})
	return true
end

local function autosaveOff()
	if not autosave_autocmd_id then
		vim.notify("Автоматическое форматирование уже отключено")
		return false
	end
	vim.api.nvim_del_autocmd(autosave_autocmd_id)
	autosave_autocmd_id = nil
	return true
end

vim.api.nvim_create_user_command("AutoformatOn", function()
	if autosaveOn() then
		vim.notify("Автоматическое форматирование включено")
	end
end, {})

vim.api.nvim_create_user_command("AutoformatOff", function()
	if autosaveOff() then
		vim.notify("Автоматическое форматирование отключено")
	end
end, {})

autosaveOn()

vim.keymap.set("n", "<leader>p", conform.format)
