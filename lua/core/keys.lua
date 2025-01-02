local set_key = require('core.utils').set_key
-- Move current line up(K) or down(J)
set_key('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
set_key('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

-- Navigation
set_key('n', 'H', '<cmd>tabprevious<cr>', { desc = 'Prev Tab' })
set_key('n', 'L', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
set_key('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next Buf' })
set_key('n', '<S-Tab>', '<cmd>bprevious<CR>', { desc = 'Prev Buf' })
set_key('n', '<BS>', '<cmd>b#<CR>', { desc = 'Prev Buf' })

-- Place cursor always at the middle
set_key('n', '<C-d>', '<C-d>zz')
set_key('n', '<C-u>', '<C-u>zz')
set_key('n', 'n', 'nzzzv')
set_key('n', 'N', 'Nzzzv')

-- Resize window using <shift> arrow keys
set_key('n', '<Up>', '<cmd>resize +2<CR>')
set_key('n', '<Down>', '<cmd>resize -2<CR>')
set_key('n', '<Left>', '<cmd>vertical resize -2<CR>')
set_key('n', '<Right>', '<cmd>vertical resize +2<CR>')

-- Clipboard
-- set_key("x", "<leader>p", [["_dP]], { desc = "Replace without overwriting" })
set_key({ 'n', 'v' }, '<space>y', [["+y]], { desc = 'SysClipboard' })
-- set_key({"n", "v"}, "<leader>d", [["_d]], { desc = "Delete without overwriting" })

-- Exit insert mode
set_key('i', 'kj', '<ESC>', { desc = 'Exit insert mode' })
set_key('t', 'KJ', '<C-\\><C-N>', { desc = 'Exit insert mode' })

-- Terminal
set_key('t', '<C-h>', '<C-\\><C-N><C-w>h')
set_key('t', '<C-j>', '<C-\\><C-N><C-w>j')
set_key('t', '<C-k>', '<C-\\><C-N><C-w>k')
set_key('t', '<C-l>', '<C-\\><C-N><C-w>l')

-- Navigate over quickfix list
set_key('n', '<M-j>', '<cmd>cnext<CR>')
set_key('n', '<M-k>', '<cmd>cprevious<CR>')

-- Close things
set_key('n', '<space>xw', '<cmd>close<CR>', { desc = 'window' })
set_key('n', '<space>xb', '<cmd>bdelete!<CR>', { desc = 'buffer' })
set_key('n', '<space>xt', '<cmd>tabo<CR>', { desc = 'All Tabs' })
set_key('n', '<space>xT', '<cmd>tabclose<CR>', { desc = 'Curr Tabs' })
set_key('n', '<space>xx', '<cmd>quit<CR>', { desc = 'Quit' })
set_key('n', '<space>xf', '<cmd>fclose<CR>', { desc = 'Quit Float Win' })

set_key('n', '<space>w', '<cmd>write<CR>', { desc = 'Write' })
