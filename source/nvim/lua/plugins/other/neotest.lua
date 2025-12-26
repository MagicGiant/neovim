local function testConfig()
	require("neotest").setup({
		adapters = {
			require("neotest-go"),
		},
	})
end

local function goTestConfig()
	local neotest_ns = vim.api.nvim_create_namespace("neotest")
	vim.diagnostic.config({
		virtual_text = {
			format = function(diagnostic)
				local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
				return message
			end,
		},
	}, neotest_ns)
end

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		{
			"nvim-neotest/neotest-go",
			config = goTestConfig,
		},
	},
	config = testConfig,
	enabled = false,
}
