-- vim.keymap.set({ 'n', 'x', 'o' }, '<A-s>', function()
--   local current_window = vim.fn.win_getid()
-- 	require('leap').leap({ target_windows = { current_window } })
-- end, { noremap = true})

vim.keymap.set({'n', 'o'}, 'gs', function ()
  require('leap.remote').action {
    -- Automatically enter Visual mode when coming from Normal.
    input = vim.fn.mode(true):match('o') and '' or 'v'
  }
end)
