local is_code_chunk = function()
  local current, _ = require('otter.keeper').get_current_language_context()
  if current then
    return true
  else
    return false
  end
end

local ft = { 'quarto', 'markdown' }

return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    ft = { 'markdown', 'quarto' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = { lsp = { enabled = true }, blink = { enabled = true } },
      file_types = { 'markdown', 'quarto' },
      heading = {
        icons = { '█ ', '▆ ', '▅ ', '▄ ', '▃ ', '▂ ' },
        sign = false,
        position = 'inline',
        width = 'block',
        min_width = 100,
        border_virtual = true,
        above = '',
      },
      code = {
        language_border = ' ',
        language_left = '',
        language_right = '',
        border = 'thin',
        sign = false,
        width = 'block',
        min_width = 100,
      },
      dash = { width = 100 },
      bullet = { ordered_icons = '' },
      pipe_table = { preset = 'round' },
    },
  },
  {
    'jakewvincent/mkdnflow.nvim',
    ft = { 'markdown', 'quarto' },
    opts = {
      modules = {
        conceal = false,
      },
      filetypes = { qmd = true, quarto = true },
      perspective = { priority = 'root', root_tell = 'index.qmd', fallback = 'first' },
      links = {
        implicit_extension = 'qmd',
        transform_explicit = function(input)
          text = text:gsub(' ', '-')
          text = text:lower()
          return text
        end,
      },
      new_file_template = {
        use_template = true,
        template = [[
---
title: {{ title }}
author: {{ author }} 
date: {{ date }}
date-modified: today
---]],
        placeholders = {
          before = {
            date = function()
              return os.date '%A, %B %d, %Y' -- Wednesday, March 1, 2023
            end,
            author = function()
              return 'junjoza'
            end,
          },
          after = {
            filename = function()
              return vim.api.nvim_buf_get_name(0)
            end,
          },
        },
      },
      mappings = {
        MkdnEnter = { { 'i', 'n', 'v' }, '<cr>' },
        MkdnCreateLinkFromClipboard = { { 'n', 'v' }, '<localleader>mp' },
        MkdnUpdateNumbering = { 'n', '<localleader>mU' },
        MkdnTableNewRowBelow = { 'n', '<localleader>mr' },
        MkdnTableNewRowAbove = { 'n', '<localleader>mR' },
        MkdnTableNewColAfter = { 'n', '<localleader>mc' },
        MkdnTableNewColBefore = { 'n', '<leader>mC' },
        MkdnFoldSection = { 'n', '<localleader>mf' },
        MkdnUnfoldSection = { 'n', '<localleader>mF' },
        MkdnIncreaseHeading = { 'n', '<localleader>k' },
        MkdnDecreaseHeading = { 'n', '<localleader>j' },
        MkdnDestroyLink = { 'n', '<localleader>md' },
        MkdnTagSpan = { 'v', '<localleader>md' },
        MkdnToggleToDo = false,
      },
    },
    keys = {
      { '<m-cr>', function() 
        if is_code_chunk() then
          print('juay')
          vim.cmd[[QuartoSend]]
        else
          vim.cmd[[MkdnToggleToDo]]
        end
      end, mode = { 'n', 'v' }, ft = ft, desc = '' },
    }
  },
}
