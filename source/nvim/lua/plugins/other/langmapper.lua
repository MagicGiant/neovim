return {
	"Wansmer/langmapper.nvim",
	lazy = false,
	priority = 1,
	config = function()
		local escape = function(str)
			local escape_chars = [[;,."|\]]
			return vim.fn.escape(str, escape_chars)
		end

		local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
		local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
		local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
		local ru_shift = [[ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

		vim.opt.langmap = vim.fn.join({
			escape(ru_shift) .. ";" .. escape(en_shift),
			escape(ru) .. ";" .. escape(en),
		}, ",")

		require("langmapper").setup({
			map_all_ctrl = true,
			hack_keymap = true,
		})
	end,
}
