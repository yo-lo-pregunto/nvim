local ft = vim.g.my_notes_fts

return {
  {
    'jmbuhr/otter.nvim',
    version = '*',
    opts = {},
    lazy = true,
  },
  {
    'junjoza/molten-nvim',
    branch = 'header-stable',
    ft = ft,
    build = ':UpdateRemotePlugins',
    init = function()
      vim.g.molten_image_provider = 'none'
      vim.g.molten_output_win_max_height = 12
      vim.g.molten_auto_open_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_status_on_header = true
      vim.g.molten_enter_output_behavior = "open_and_enter"
      vim.g.molten_output_show_more = true
      vim.g.molten_use_border_highlights = true
    end,
    config = function()
      -- see :h nvim_set_hl for what to put in place of ...
      -- I would recommend using the `link` option to link the values to colors from your color scheme
      vim.api.nvim_set_hl(0, 'MoltenOutputBorder', { link = 'DiagnosticVirtualTextInfo' })
      vim.api.nvim_set_hl(0, 'MoltenOutputBorderSuccess', { link = 'DiagnosticVirtualTextOk' })
      vim.api.nvim_set_hl(0, 'MoltenOutputBorderFail', { link = 'DiagnosticVirtualTextError' })
    end,
  },
  {
    'quarto-dev/quarto-nvim',
    version = '*',
    dependencies = {
      'jmbuhr/otter.nvim',
      'junjoza/molten-nvim',
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
      { '<localleader>O', ':noautocmd MoltenEnterOutput<CR>', ft = 'quarto', desc = 'show/enter output' },
      { '<localleader>I', ':MoltenInit<cr>', ft = 'quarto', desc = 'Init' },
    },
  },
}
