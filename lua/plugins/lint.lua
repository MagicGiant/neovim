local lint = require('lint')

lint.linters_by_ft = {
	javascript = {'biomejs'},
	lua = {'luacheck'}
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

local id_lint_autocmd = nil

local function auto_lint_on ()
	if id_lint_autocmd then
		vim.notify("Автоматический линтинг уже включен")
		return false
	end
	id_lint_autocmd = vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			lint.try_lint()
		end,
	})

	return true
end

local function auto_lint_off()
	if not id_lint_autocmd then
		vim.notify("Автоматический линтинг уже выключен")
		return false
	end

	vim.api.nvim_del_autocmd(id_lint_autocmd)
	id_lint_autocmd = nil

	return true
end

vim.api.nvim_create_user_command("AutoLintOn", function()
	if auto_lint_on() then
		vim.notify("Автоматический линтинг включен")
	end
end, {})

vim.api.nvim_create_user_command("AutoLintOff", function()
	if auto_lint_off() then
		vim.notify("Автоматический линтинг выключен")
	end
end, {})

auto_lint_on()

vim.keymap.set("n", "<leader>l", function()
		lint.try_lint()
end, { desc = "Trigger linting fro current file" })
