-- Editor plugin

-- Tmux & split window navigation
return {
  {
    'christoomey/vim-tmux-navigator',
    init = function()
      vim.keymap.set('t', '<C-h>', '<C-\\><C-N>:TmuxNavigateLeft<CR>', { silent = true })
      vim.keymap.set('t', '<C-j>', '<C-\\><C-N>:TmuxNavigateDown<CR>', { silent = true })
      vim.keymap.set('t', '<C-k>', '<C-\\><C-N>:TmuxNavigateUp<CR>', { silent = true })
      vim.keymap.set('t', '<C-l>', '<C-\\><C-N>:TmuxNavigateRight<CR>', { silent = true })
    end,
  },
}
