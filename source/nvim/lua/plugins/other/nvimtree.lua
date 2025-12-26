local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local opts = function(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	-- Привязки клавиш, которые требуют bufnr
	vim.keymap.set("n", "<C-[>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "<C-h>", api.node.navigate.parent_close, opts("Close Directory"))
	vim.keymap.set("n", "<C-i>", api.node.show_info_popup, opts("Info"))
	vim.keymap.set("n", "<C-l>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<C-k>", api.node.navigate.sibling.prev, opts("Previous Sibling"))
	vim.keymap.set("n", "<C-j>", api.node.navigate.sibling.next, opts("Next Sibling"))
end

local function config()
	vim.keymap.set("n", "<leader>e", "<Cmd>NvimTreeOpen<CR>")
	vim.keymap.set("n", "<leader>E", "<Cmd>NvimTreeClose<CR>")

	local api = require("nvim-tree.api")

	-- Добавляем функцию opts для использования в keymap.set

	-- Основная конфигурация nvim-tree
	require("nvim-tree").setup({
		on_attach = on_attach,
		-- Другие настройки nvim-tree можно добавить здесь
		-- Например:
		-- view = {
		-- 	width = 30,
		-- },
		-- renderer = {
		-- 	indent_markers = {
		-- 		enable = true,
		-- 		icons = {
		-- 			corner = "└",
		-- 			edge = "│",
		-- 			item = "│",
		-- 			none = " ",
		-- 		},
		-- 	},
		-- },
	})
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = config,
	-- enabled = false,
}
