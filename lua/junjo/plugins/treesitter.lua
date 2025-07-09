return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  opts = {
    install_dir = vim.fn.stdpath 'data' .. '/site',
  },
  config = function()
    local ts = require 'nvim-treesitter'
    local languages = { 'rust', 'c', 'lua', 'python', 'markdown' }
    ts.install(languages)

    vim.keymap.set('n', '<leader>cp', function()
      local ft = vim.bo.filetype
      local lang = vim.treesitter.language.get_lang(ft)

      vim.notify('Installing Tree-sitter parser for ' .. lang)
      ts.install(lang, { summary = true })
    end, { desc = 'Install TS Parser' })
  end,
}
