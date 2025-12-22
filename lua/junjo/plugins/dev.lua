return {
  { 'j-hui/fidget.nvim', version = '*', opts = {} },
  {
    'junjoza/query-driver.nvim',
    lazy = true,
  },
  {
    'b0o/schemastore.nvim',
    lazy = true,
  },
  {
    'christoomey/vim-tmux-navigator',
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    event = 'ModeChanged *:[vV\x16]', -- load in visual / visual line or Visual block
    opts = {},
  },
  -- Lua
  {
    'folke/zen-mode.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}
