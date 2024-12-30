-- Editor plugin

return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    build = ':TSUpdate',
    event = { 'VeryLazy', 'BufReadPre' },
    opts = {
      auto_install = true,
      ensure_installed = {
        'python',
        'c',
        'markdown',
        'markdown_inline',
        'bash',
        'yaml',
        'lua',
        'vim',
        'query',
        'vimdoc',
      },
      highlight = {
        enable = true,
        disable = { 'latex' },
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gn',
          node_incremental = ']]',
          scope_incremental = false,
          node_decremental = '[[',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']C'] = '@class.outer',
            [']b'] = { query = '@code_cell.inner', desc = 'next code block' },
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[C'] = '@class.outer',
            ['[b'] = { query = '@code_cell.inner', desc = 'previous code block' },
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
