return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  opts = {
    install_dir = vim.fn.stdpath('data') .. '/site',
  },
  config = function()
    local ts = require'nvim-treesitter'
    local languages = { 'rust', 'c', 'lua', 'python', 'markdown' }
    ts.install(languages)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = languages,
      callback = function() vim.treesitter.start() end
    })
  end
}
