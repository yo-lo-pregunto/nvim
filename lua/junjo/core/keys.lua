local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move current line up(K) or down(J)
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

-- Indentention level
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Place cursor always at the middle
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Resize window using arrow keys
vim.keymap.set('n', '<Up>', '<cmd>resize +2<CR>')
vim.keymap.set('n', '<Down>', '<cmd>resize -2<CR>')
vim.keymap.set('n', '<Left>', '<cmd>vertical resize -2<CR>')
vim.keymap.set('n', '<Right>', '<cmd>vertical resize +2<CR>')

-- Exit insert mode
vim.keymap.set('i', 'kj', '<ESC>', { desc = 'Exit insert mode' })
vim.keymap.set('t', 'KJ', '<C-\\><C-N>', { desc = 'Exit insert mode' })

-- Clipboard
vim.keymap.set({ 'n', 'v' }, '<space>y', [["+y]], { desc = 'SysClipboard' })

-- Terminal
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l')

-- Clear search highlights
vim.keymap.set('n', '<C-c>', '<cmd>nohl<cr>', { desc = 'Clear search hl', silent = true })
