-- Status Line
return {
  'sschleemilch/slimline.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    { 'echasnovski/mini.icons', version = '*' },
  },
  opts = {
    style = 'fg',
    bold = true,
    hl = {
      secondary = 'Comment',
    },
    configs = {
      mode = {
        hl = {
          normal = 'Type',
          visual = 'Keyword',
          insert = 'Function',
          replace = 'Statement',
          command = 'String',
          other = 'Function',
        },
      },
      path = {
        hl = {
          primary = 'Label',
        },
      },
      git = {
        hl = {
          primary = 'Function',
        },
      },
      filetype_lsp = {
        hl = {
          primary = 'String',
        },
      },
    },
  },
}
