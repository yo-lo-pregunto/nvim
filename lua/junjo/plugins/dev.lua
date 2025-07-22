return {
  { 'j-hui/fidget.nvim', opts = {} },
  {
    'junjoza/query-driver.nvim', lazy = true,
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
    event = "ModeChanged *:[vV\x16]", -- load in visual / visual line or Visual block
    opts = {}
  },
}
