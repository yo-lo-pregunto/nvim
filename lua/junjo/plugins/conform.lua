return {
  'stevearc/conform.nvim',
  version = '*',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
    },
  },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format()
      end,
      desc = 'Format',
    },
  },
}
