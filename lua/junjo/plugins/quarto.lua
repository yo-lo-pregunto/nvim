return {
  {
    'jmbuhr/otter.nvim',
    opts = {},
  },
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    build = ':UpdateRemotePlugins',
    init = function()
      vim.g.molten_image_provider = 'none'
      vim.g.molten_output_win_max_height = 15
      vim.g.molten_auto_open_output = true
      vim.g.molten_wrap_output = true
    end,
  },
  {
    'quarto-dev/quarto-nvim',
    dependencies = {
      'jmbuhr/otter.nvim',
      'benlubas/molten-nvim',
    },
    ft = { 'quarto' },
    opts = {
      debug = true,
      closePreviewOnExit = true,
      lspFeatures = {
        chunks = 'curly',
        completion = {
          enabled = true,
        },
        diagnostics = {
          enabled = true,
          triggers = { 'BufWritePost' },
        },
      },
      codeRunner = {
        enabled = true,
        default_method = 'molten',
      },
    },
  },
}
