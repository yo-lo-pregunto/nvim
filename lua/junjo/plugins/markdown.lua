return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ft = { 'markdown', 'quarto' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = { lsp = { enabled = false } },
      file_types = { 'markdown', 'quarto' }
    },
  },
}
