require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local registry = require("mason-registry")

local checkAndInstall = function(strs)
	for i = 1, #strs do
		if not registry.is_installed(strs[i]) then
			vim.cmd(":MasonInstall " .. strs[i])
		end
	end
end

checkAndInstall({
	-- lsp
	"lua-language-server",
	"ty",
	"typescript-language-server",
	"biome",
	"stylua",
	"luacheck",
	"gopls",
	"crlfmt",
})
