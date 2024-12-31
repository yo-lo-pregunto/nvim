---@diagnostic disable-next-line: unused-local
local format = vim.g.personal_options.date_format
local n = vim.g.personal_options.neorg

local function setup_loading_template_on_new_file()
  local group = vim.api.nvim_create_augroup('NeorgLoadTemplateGroup', { clear = true })

  local is_buffer_empty = function(buffer)
    local content = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
    return not (#content > 1 or content[1] ~= '')
  end

  local callback = function(args)
    vim.schedule(function()
      if not is_buffer_empty(args.buf) then
        return
      end

      if string.find(args.file, '/journal/') then
        debug('loading template "journal" ' .. args.event)
        vim.api.nvim_cmd({ cmd = 'Neorg', args = { 'templates', 'fload', 'journal' } }, {})
      else
        debug('add metadata ' .. args.event)
        vim.api.nvim_cmd({ cmd = 'Neorg', args = { 'inject-metadata' } }, {})
      end
    end)
  end

  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufNew' }, {
    desc = 'Load template on new norg files',
    pattern = '*.norg',
    callback = callback,
    group = group,
  })
end
return {
  {
    'nvim-neorg/neorg',
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    dependencies = {
      'benlubas/neorg-interim-ls',
      'nvim-neorg/neorg-telescope',
      { 'pysan3/neorg-templates', dependencies = { 'L3MON4D3/LuaSnip' } },
    },
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {}, -- Loads default behaviour
          ['core.summary'] = {},
          ['core.export'] = {},
          ['core.integrations.telescope'] = {},
          ['core.concealer'] = { config = { folds = true, icons_preset = 'diamond' } }, -- Adds pretty icons to your documents
          ['core.esupports.metagen'] = { config = { type = 'none', update_date = true } },
          ['core.completion'] = { config = { engine = { module_name = 'external.lsp-completion' } } },
          ['core.export.markdown'] = { config = { extensions = 'all' } },
          ['core.dirman'] = { -- Manages Neorg workspaces
            config = {
              workspaces = n.workspaces,
              default_workspace = n.default_workspace,
            },
          },
          ['core.journal'] = {
            config = {
              strategy = 'flat',
              workspace = n.default_workspace,
              use_template = false,
            },
          },
          ['external.interim-ls'] = {
            config = {
              completion_provider = {
                enable = true,
                documentation = true,
                categories = false,
                test = { enable = true, path = 'test' },
              },
            },
          },
          ['external.templates'] = {
            config = {
              keywords = require 'core.norg',
            },
          },
        },
      }
      vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufNew' }, {
        command = 'Neorg templates fload journal',
        pattern = { n.workspaces.notes .. '/journal/*.norg' },
      })

      vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufNew' }, {
        command = 'Neorg templates fload ticket',
        pattern = { n.workspaces.notes .. '/tickets/*.norg' },
      })
    end,
    keys = {
      { '<leader>ni', '<cmd>Neorg index<cr>', desc = 'Index' },
      { '<leader>nk', '<cmd>Neorg journal today<cr>', desc = 'Jornal Today' },
      { '<leader>nj', '<cmd>Neorg journal yesterday<cr>', desc = 'Journal Yesterday' },
      { '<leader>nl', '<cmd>Neorg journal tomorrow<cr>', desc = 'Journal Tomorrow' },
      { '<leader>no', '<cmd>Neorg journal custom<cr>', desc = 'Other day' },
    },
  },
}
