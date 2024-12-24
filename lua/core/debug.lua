vim.keymap.set('n', '<space><space>s', '<cmd>source %<CR>', { desc = 'source file' })
vim.keymap.set('n', '<space><space>l', ':.lua<CR>', { desc = 'source line' })
vim.keymap.set('v', '<space>s', ':.lua<CR>', { desc = 'source lines' })
