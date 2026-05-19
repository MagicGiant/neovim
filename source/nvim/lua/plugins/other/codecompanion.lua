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
				http = {
					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							env = {
								url = "https://my_ollama_url",
							},
							headers = {
								["Content-Type"] = "application/json",
							},
							parameters = {
								sync = true,
							},
						})
					end,
				},
			},
		})
	end,
}
