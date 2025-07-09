local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

-- Tree Sitter Keymaps
-- Keymap to Toggle Tree-sitter Highlight on current buffer
vim.keymap.set('n', '<leader>ch', function()
  local ft = vim.bo.filetype
  local lang = vim.treesitter.language.get_lang(ft)

  -- Check if there is any parser for the current buffer
  if not vim.treesitter.language.add(lang) then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local highlighter = vim.treesitter.highlighter

  local is_active = highlighter.active[bufnr] ~= nil

  if is_active then
    vim.treesitter.stop(bufnr)
    vim.notify('Tree-sitter disabled Highlight: ' .. bufnr)
  else
    vim.treesitter.start(bufnr, lang)
    vim.notify('Tree-sitter enabled Highlight: ' .. bufnr)
  end
end, { desc = 'Toggle Tree-sitter highlight' })

-- Keymap to Toggle Tree-sitter Fold on current buffer
vim.keymap.set('n', '<leader>cf', function()
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
  end
end, { desc = 'Toggle Tree-sitter folding' })
