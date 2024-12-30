-- ui plugin

local function maximize_status()
  return vim.t['maximized'] and ' ' or ''
end

local function shorter_name(filename)
  return filename:match '([^/]+)$'
end

local actived_venv = function()
  -- Lualine is not resposable of loading venv-selector
  if package.loaded['venv-selector'] == nil then
    return ''
  end
  local venv_name = require('venv-selector').venv()
  if venv_name ~= nil then
    return '  ' .. shorter_name(venv_name)
  else
    return ''
  end
end

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'meuter/lualine-so-fancy.nvim' },
    },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        always_divide_middle = false,
      },
      sections = {
        lualine_a = {
          { 'fancy_mode', width = 6 },
        },
        lualine_b = {
          { 'branch' },
          { 'fancy_diff' },
          { 'fancy_diagnostics' },
        },
        lualine_c = {
          { 'fancy_cwd', substitute_home = true },
          { 'filename', path = 1 },
          {
            'maximized-status',
            fmt = maximize_status,
          },
        },
        lualine_x = {
          { 'fancy_macro', icon = { ' ', color = 'WarningMsg' } },
          { 'fancy_searchcount', icon = { ' ', color = { fg = '#FCBA03' } } },
          { actived_venv },
        },
        lualine_y = {
          { 'encoding' },
          { 'fileformat' },
          { 'filetype' },
          { 'fancy_lsp_servers', icon = { '', color = { fg = '#FFFF00' } } },
          { actived_venv },
        },
        lualine_z = {
          { 'selectioncount' },
          { '%l/%L:%02c' },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'toggleterm' },
    },
  },
}
