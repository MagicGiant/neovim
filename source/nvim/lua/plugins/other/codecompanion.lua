return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		-- NOTE: The log_level is in `opts.opts`
		opts = {
			log_level = "DEBUG", -- or "TRACE"
		},
	},
	config = function()
		require("codecompanion").setup({
			adapters = {
				deepseek = function()
					return require("codecompanion.adapters").extend("deepseek", {
						schema = {
							model = {
								default = "deepseek-v4-flash", -- или "deepseek-v4-pro"
							},
							max_tokens = {
								default = 384000, -- Максимальный вывод для v4
							},
						},
					})
				end,
			},
			strategies = {
				chat = { adapter = "deepseek" },
				inline = { adapter = "deepseek" },
			},
		})
	end,
}
