local function config()
	require("nvim-ts-autotag").setup({
		opts = {
			-- Defaults
			enable_close = true, -- Auto close tags
			enable_rename = true, -- Auto rename pairs of tags
			enable_close_on_slash = false, -- Auto close on trailing </
		},
		per_filetype = {
			["handlebars"] = {
				enable_close = true,
			},
			["ejs"] = {
				enable_close = true,
			},
		},
	})
end

return {
	"windwp/nvim-ts-autotag",
	config = config,
}
