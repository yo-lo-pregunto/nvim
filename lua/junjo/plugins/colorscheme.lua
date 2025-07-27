return {
  {
    'vague2k/vague.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      if vim.g.neovim_mode == 'default' then
        vim.cmd [[colorscheme vague]]
      end
    end,
  },
  {
    'forest-nvim/sequoia.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      if vim.g.neovim_mode == 'notes' then
        vim.cmd [[colorscheme gruvbox]]
      end
    end,
  },
}
