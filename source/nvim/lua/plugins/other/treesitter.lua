local function config()
	local ensureInstalled = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
<<<<<<< HEAD
		"markdown",
		"markdown_inline",
=======
		-- "markdown",
		-- "markdown_inline",
>>>>>>> 37c4fe8 (changes)
		"go",
		"javascript",
		"typescript",
		"jsdoc",
		"html",
	}
	local alreadyInstalled = require("nvim-treesitter").get_installed()
	local parsersToInstall = vim.iter(ensureInstalled)
		:filter(function(parser)
			return not vim.tbl_contains(alreadyInstalled, parser)
		end)
		:totable()
	require("nvim-treesitter").install(parsersToInstall)

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "markdown",
		callback = function()
			vim.treesitter.start()
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			-- Enable treesitter highlighting and disable regex syntax
			pcall(vim.treesitter.start)
			-- Enable treesitter-based indentation
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	config = config,
}
