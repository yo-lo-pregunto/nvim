return {
  {
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  },
  {
    'pteroctopus/faster.nvim',
    lazy = false,
    priority = 100,
  },
  {
    'chrishrb/gx.nvim',
    keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
    cmd = { 'Browse' },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      filetypes = {
        '*', -- Highlight all files, but customize some others.
        '!vim', -- Exclude vim from highlighting.
        '!help', -- Exclude vim from highlighting.
        -- Exclusion Only makes sense if '*' is specified!
      },
    },
  },
}
