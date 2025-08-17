return {
  'L3MON4D3/LuaSnip',
  dependencies = { 'rafamadriz/friendly-snippets' },
  lazy = true,
  version = 'v2.*',
  run = 'make install_jsregexp',
  config = function(_, opts)
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip').filetype_extend('c', { 'cdoc' })

    local ls = require 'luasnip'
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node

    ls.add_snippets('quarto', {
      s({
        name = 'title',
        trig = 'tt',
        desc = 'Add Yaml title'
      }, {
        t { '---', 'title: ' },
        i(1, 'Your title'),
        t { '', 'author: ' },
        f(function()
          return vim.fn.system('whoami'):sub(1, -2)
        end, {}),
        t { '', 'date: ' },
        f(function()
          return os.date '%A, %B %d, %Y'
        end, {}),
        t { '', 'date-modified: today', '---', '' },
      }),
    })
  end,
}
