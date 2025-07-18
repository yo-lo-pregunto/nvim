-- Status Line

local actived_venv = function()
  -- Lualine is not resposable of loading venv-selector
  if package.loaded['venv-selector'] == nil then
    return ''
  end
  local venv_name = require('venv-selector').venv()
  if venv_name ~= nil then
    return '  ' .. vim.fn.fnamemodify(venv_name, ':t')
  else
    return ''
  end
end

return {
  'sschleemilch/slimline.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    { 'echasnovski/mini.icons', version = '*' },
  },
  event = 'VeryLazy',
  opts = {
    components = {
      right = { actived_venv, 'diagnostics', 'filetype_lsp', 'progress' },
    },
    style = 'fg',
    bold = true,
    hl = {
      secondary = 'Comment',
    },
    configs = {
      mode = {
        hl = {
          normal = 'Type',
          visual = 'Keyword',
          insert = 'Function',
          replace = 'Statement',
          command = 'String',
          other = 'Function',
        },
      },
      path = {
        hl = {
          primary = 'Label',
        },
      },
      git = {
        hl = {
          primary = 'Function',
        },
      },
      filetype_lsp = {
        hl = {
          primary = 'String',
        },
      },
    },
  },
}
