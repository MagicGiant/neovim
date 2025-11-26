vim.keymap.set("n", "<leader>e", "<Cmd>NvimTreeOpen<CR>")
vim.keymap.set("n", "<leader>E", "<Cmd>NvimTreeClose<CR>")

local function my_on_attach(bufnr)
	local tree = require("nvim-tree")
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- tree.renderer.indent_markers.icons{
	-- 	corner = "A",
	-- 	edge = "B",
	-- 	item = "C",
	-- 	bottom = "D",
	-- 	none = " ",
	-- }

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<C-[>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "<C-h>", api.node.navigate.parent_close, opts("Close Directory"))
	vim.keymap.set("n", "<C-i>", api.node.show_info_popup, opts("Info"))
	vim.keymap.set("n", "<C-l>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<C-k>", api.node.navigate.sibling.prev, opts("Next Sibling"))
	vim.keymap.set("n", "<C-j>", api.node.navigate.sibling.next, opts("Next Sibling"))
end

require("nvim-tree").setup({
	on_attach = my_on_attach,
})
