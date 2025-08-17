return {
  'folke/which-key.nvim',
  version = '*',
  event = 'VeryLazy',
  ---@type wk.Opts
  opts = {
    preset = 'modern',
    spec = {
      { '<leader>b', group = 'Buffer', icon = '' },
      { '<leader>c', group = 'Code', icon = '' },
      { '<leader>g', group = 'Git', icon = '' },
      { '<leader>s', group = 'Search', icon = '' },
      { '<leader>t', group = 'textobject' },
      { '<leader>ts', group = 'swap' },
      { ']', group = 'Next', icon = '⏭︎ ' },
      { '[', group = 'Prev', icon = '⏮︎ '},
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Local Keymaps',
    },
  },
}
