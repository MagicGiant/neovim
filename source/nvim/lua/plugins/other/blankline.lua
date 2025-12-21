local function config()
	local ibl = require("ibl")
	ibl.setup({
		scope = {
			enabled = false,
		},
	})

	ibl.overwrite({
		exclude = {
			filetypes = {
				"dashboard",
				"lspinfo",
				"packer",
				"checkhealth",
				"help",
				"man",
				"gitcommit",
				"TelescopePrompt",
				"TelescopeResult",
			},
		},
	})
end

return {
	"lukas-reineke/indent-blankline.nvim",
	config = config,
}
