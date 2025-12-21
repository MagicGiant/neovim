local function config()
	vim.keymap.set({ "n", "o" }, "gs", function()
		require("leap.remote").action({
			-- Automatically enter Visual mode when coming from Normal.
			-- input = vim.fn.mode(true):match("o") and "" or "v",
		})
	end)
end

return {
	"ggandor/leap.nvim",
	-- keys = { "s" },
	config = config,
}
