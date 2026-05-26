return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local npairs = require("nvim-autopairs")
		local cond = require("nvim-autopairs.conds")
		local Rule = require("nvim-autopairs.rule")

		npairs.setup({
			check_ts = true, -- проверять tree-sitter
		})
	end,
}
