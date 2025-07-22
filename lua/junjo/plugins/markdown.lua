local ft = vim.g.my_notes_fts

return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    ft = ft,
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = { lsp = { enabled = true }, blink = { enabled = true } },
      file_types = ft,
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
    ft = ft,
    opts = {
      modules = {
        conceal = false,
      },
      filetypes = { qmd = true, quarto = true },
      perspective = { priority = 'root', root_tell = 'index.qmd', fallback = 'first' },
      links = {
        conceal = false,
        implicit_extension = 'qmd',
        transform_explicit = function(text)
          in_notebook = require'mkdnflow'.root_dir
          text = text:gsub(' ', '-')
          text = text:lower()
          return in_notebook and ('/' .. text) or text
        end,
        transform_implicit = function(text)
          in_notebook = require'mkdnflow'.root_dir
          if in_notebook and string.sub(text, 1, 1) == '/' then
            return string.sub(text, 2)
          else
            return text
          end
        end
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
              return vim.fn.system('whoami'):sub(1, -2)
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
  },
}
