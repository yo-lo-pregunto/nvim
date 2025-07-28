return {
  'L3MON4D3/LuaSnip',
  dependencies = { 'rafamadriz/friendly-snippets' },
  lazy = true,
  version = 'v2.*',
  run = 'make install_jsregexp',
  config = function(_, opts)
    require'luasnip.loaders.from_vscode'.lazy_load()
    require('luasnip').filetype_extend('c', { 'cdoc' })
  end,
}
