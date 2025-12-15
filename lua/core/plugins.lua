local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	{ "phaazon/hop.nvim" },
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
	},
	{ "nvim-treesitter/nvim-treesitter", branch = "main" },
	{ "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"jake-stewart/multicursor.nvim",
	},
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	{ "numToStr/Comment.nvim" },
	{ "windwp/nvim-ts-autotag" },
	-- { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	{ "nvim-lua/plenary.nvim" },
	{ "ThePrimeagen/harpoon", dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "hadronized/hop.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "sphamba/smear-cursor.nvim" },
	{ "heavenshell/vim-jsdoc", opt = {} },
	{
		"ggandor/leap.nvim",
		keys = { "s" },
	},
	{
		"rcarriga/nvim-notify",
	},
	{
		"tpope/vim-surround",
	},
	{
		"antoinemadec/FixCursorHold.nvim",
	},
	-- tests
	{ "nvim-neotest/nvim-nio" },
	-- {
	-- 	"nvim-neotest/neotest-go",
	-- },
	-- {
	-- 	"fredrikaverpil/neotest-golang",
	-- 	version = "*", -- Optional, but recommended; track releases
	-- 	build = function()
	-- 		vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
	-- 	end,
	-- },
	-- {
	-- 	"nvim-neotest/neotest",
	-- 	dependencies = {
	-- 		"nvim-neotest/nvim-nio",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"antoinemadec/FixCursorHold.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- },
	-- {
	-- 	"fredrikaverpil/neotest-golang",
	-- 	version = "*", -- Optional, but recommended; track releases
	-- 	build = function()
	-- 		vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
	-- 	end,
	-- },
	-- lsp
	{ "mason-org/mason.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "mfussenegger/nvim-dap" },
	-- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	-- { "dense-analysis/ale" },
	{ "puremourning/vimspector" },
	{ "mfussenegger/nvim-lint" },
	{ "hrsh7th/vim-vsnip" },
	{ "stevearc/conform.nvim" },
	{
		"danymat/neogen",
		config = true,
	},
	-- { "nvimdev/dashboard-nvim" },
	-- themes
	-- {"navarasu/onedark.nvim"},
	-- {"marko-cerovac/material.nvim"},
	-- {"embark-theme/vim"},
	{ "sainnhe/everforest" },
	-- auto complite
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	-- git
	{ "lewis6991/gitsigns.nvim" },
})
