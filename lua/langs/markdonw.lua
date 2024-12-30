return {
  server = { 'marksman' },
  opts = {
    filetypes = {
      'markdown',
      'quarto',
    },
    root_dir = function(fname)
      local util = require 'lspconfig.util'
      return util.root_pattern('.git', '.marksman.toml', '_quarto.yml')(fname) or vim.fs.dirname(fname)
    end,
  },
}
