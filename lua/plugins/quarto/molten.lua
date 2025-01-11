return {
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    dependencies = { '3rd/image.nvim' },
    build = ':UpdateRemotePlugins',
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_output_win_max_height = 15
      vim.g.molten_auto_open_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = false
      vim.g.molten_virt_lines_off_by_1 = false
      vim.g.molten_virt_status_on_header = true

      -- Highlights
      vim.api.nvim_set_hl(0, 'MoltenCell', {})
    end,
    ft = { 'quarto', 'markdown', 'norg' },
  },
}
