local ft = vim.g.my_notes_fts

return {
  {
    'jmbuhr/otter.nvim',
    version = '*',
    opts = {},
    lazy = true,
  },
  {
    'benlubas/molten-nvim',
    ft = ft,
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
    version = '*',
    dependencies = {
      'jmbuhr/otter.nvim',
      'benlubas/molten-nvim',
    },
    ft = ft,
    opts = {
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
    keys = {
      { '<localleader>qa', ':QuartoActivate<cr>', ft = ft, desc = 'Activate' },
      { '<localleader>qp', ':QuartoPreview<cr>', ft = ft, desc = 'Preview' },
      { '<localleader>qP', ':QuartoClosePreview<cr>', ft = ft, desc = 'Close' },
      { '<localleader>qra', ':QuartoSendAll<cr>', ft = ft, desc = 'All' },
      { '<localleader>qrn', ':QuartoSendBelow<cr>', ft = ft, desc = 'Next' },
      { '<localleader>qrp', ':QuartoSendAbove<cr>', ft = ft, desc = 'Previous' },
    },
  },
}
