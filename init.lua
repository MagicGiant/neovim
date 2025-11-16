-- Basic
require('core.plugins')
require('core.general')
require('core.keymaps')
require('core.colors')

-- Plugins
require('plugins.neotree')
require('plugins.treesitter')
require('plugins.mason')
require('plugins.lsp')
require('plugins.cmp')
require('plugins.gitsings')
require('plugins.telescope')
require('plugins.autopairs')
require('plugins.comment')
-- require('plugins.bufferline')
require('plugins.hop')
require('plugins.lualine')
-- require('plugins.dashboard')


vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
