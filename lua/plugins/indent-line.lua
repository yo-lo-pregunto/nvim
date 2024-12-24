return {
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = true,
    event = 'VeryLazy',
    opts = {
      indent = {
        char = '▏',
        tab_char = '▏',
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          'help',
          'Trouble',
          'neo-tree',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
          'dashboard',
        },
      },
    },
    main = 'ibl',
  },
}
