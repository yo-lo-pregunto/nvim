local set_local = require('core.utils').set_local

local is_code_chunk = function()
  local current, _ = require('otter.keeper').get_current_language_context()
  if current then
    return true
  else
    return false
  end
end

--- Insert code chunk of given language
--- Splits current chunk if already within a chunk
--- @param lang string
local insert_code_chunk = function(lang)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'n', true)
  local keys
  if is_code_chunk() then
    keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
  else
    keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
  end
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end

local insert_py_chunk = function()
  insert_code_chunk 'python'
end

return {
  { -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
    -- for complete functionality (language features)
    'quarto-dev/quarto-nvim',
    ft = { 'quarto' },
    dev = false,
    opts = {
      closePreviewOnExit = true,
      lspFeatures = {
        chunks = 'all',
        completion = {
          enabled = true,
        },
      },

      codeRunner = {
        enabled = true,
        default_method = 'molten',
        never_run = { 'yaml' },
      },
    },
    dependencies = {
      'jmbuhr/otter.nvim',
      'benlubas/molten-nvim',
    },
    config = function(_, opts)
      require('quarto').setup(opts)

      set_local({ 'i', 'n' }, '<m-a>', insert_py_chunk, 'Insert Python chunk')
      set_local('n', '<localleader>a', ':QuartoActivate<cr>', 'Activate')
      set_local('n', '<localleader>p', ':QuartoPreview<cr>', 'Preview')
      set_local('n', '<localleader>q', ':QuartoClosePreview<cr>', 'Close')
      set_local('n', '<localleader>rs', ':QuartoSend<cr>', 'Send')
      set_local('n', '<localleader>ra', ':QuartoSendAll<cr>', 'All')
      set_local('n', '<localleader>rn', ':QuartoSendBelow<cr>', 'Next')
      set_local('n', '<localleader>rp', ':QuartoSendAbove<cr>', 'Previous')
      set_local('n', '<localleader>mi', ':MoltenInit<cr>', 'Init')
      set_local('n', '<localleader>mo', ':noautocmd MoltenEnterOutput<CR>', 'show/enter output')
      set_local('n', '<m-cr>', ':QuartoSend<cr>', 'Run Command')
      set_local('i', '<m-cr>', '<ESC>:QuartoSend<cr>', 'Run Command')
    end,
  },
}
