local function config()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			html = { "prettydiff" },
			lua = { "stylua" },
			javascript = { "biome" },
			json = { "biome" },
			go = { "gofmt" },
		},
	})

	local autoformat_cmd_id = nil

	local function autoformat_on()
		if autoformat_cmd_id then
			vim.notify("Автоматическое форматирование уже включено")
			return false
		end
		autoformat_cmd_id = vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function(args)
				conform.format({ bufnr = args.buf })
			end,
		})
		return true
	end

	local function autoformat_off()
		if not autoformat_cmd_id then
			vim.notify("Автоматическое форматирование уже отключено")
			return false
		end
		vim.api.nvim_del_autocmd(autoformat_cmd_id)
		autoformat_cmd_id = nil
		return true
	end

	vim.api.nvim_create_user_command("AutoformatOn", function()
		if autoformat_on() then
			vim.notify("Автоматическое форматирование включено")
		end
	end, {})

	vim.api.nvim_create_user_command("AutoformatOff", function()
		if autoformat_off() then
			vim.notify("Автоматическое форматирование отключено")
		end
	end, {})

	autoformat_on()

	vim.keymap.set("n", "<leader>p", conform.format)
end

return {
	"stevearc/conform.nvim",
	config = config,
}
