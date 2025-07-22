return {
  {
    'vague2k/vague.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd [[colorscheme vague]]
    end,
  },
  {
    'forest-nvim/sequoia.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { 'ellisonleao/gruvbox.nvim', lazy = false, priority = 1000, opts = {} },
}
