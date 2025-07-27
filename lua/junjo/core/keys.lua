local opts = { noremap = true, silent = true }

-- Tabs Navigation
vim.keymap.set('n', 'H', '<cmd>tabprevious<cr>', { desc = 'Prev Tab' })
vim.keymap.set('n', 'L', '<cmd>tabnext<cr>', { desc = 'Next Tab' })

-- Move current line up(K) or down(J)
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

-- Indentation level
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
vim.keymap.set({ 'n', 'v' }, '<space>y', [["+y]], { desc = 'SysCp' })

-- Terminal
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l')

-- Clear search highlights
vim.keymap.set('n', '<C-c>', '<cmd>nohl<cr>', { desc = 'Clear search hl', silent = true })

------------------------
-- Plugins Key maps
-- Tree Sitter Key maps
------------------------

-- Snacks
Snacks.toggle.treesitter():map '<leader>ch'
Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>cS'
Snacks.toggle.option('relativenumber'):map '<leader>cn'
vim.keymap.set('n', '<leader>bd', Snacks.bufdelete.delete, { desc = 'Delete', remap = true })

-- Key map to Toggle Tree-sitter Fold on current buffer
vim.keymap.set('n', '<leader>cz', function()
  local win = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_get_current_buf()

  local win_state = vim.wo[win].foldmethod == 'expr'
  local buf_state = vim.b[bufnr].folding_enabled or false

  if win_state and buf_state then
    vim.wo[win].foldmethod = 'manual'
    vim.wo[win].foldexpr = ''
    vim.b[bufnr].folding_enabled = false -- For keep track
    vim.cmd [[normal! zE]] -- Remove all folding on windows
    vim.notify('Tree-sitter disabled Folding: ' .. win .. '/' .. bufnr)
  else
    vim.wo[win].foldenable = false
    vim.wo[win].foldmethod = 'expr'
    vim.wo[win].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.b[bufnr].folding_enabled = true -- For keep track
    vim.notify('Tree-sitter enabled Folding: ' .. win .. '/' .. bufnr)

    -- Ensure proper initial folding (foldlevel=1 shows top-level folds)
    vim.wo[win].foldlevel = 1
  end
end, { desc = 'Toggle folding' })
