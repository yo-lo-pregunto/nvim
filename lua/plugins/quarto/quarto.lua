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
      'yo-lo-pregunto/molten-nvim',
    },
    keys = {
      { '<m-a>', insert_py_chunk, ft = 'quarto', desc = 'Insert Python chunk' },
      { '<localleader>a', ':QuartoActivate<cr>', ft = 'quarto', desc = 'Activate' },
      { '<localleader>p', ':QuartoPreview<cr>', ft = 'quarto', desc = 'Preview' },
      { '<localleader>q', ':QuartoClosePreview<cr>', ft = 'quarto', desc = 'Close' },
      { '<localleader>rs', ':QuartoSend<cr>', ft = 'quarto', desc = 'Send' },
      { '<localleader>ra', ':QuartoSendAll<cr>', ft = 'quarto', desc = 'All' },
      { '<localleader>rn', ':QuartoSendBelow<cr>', ft = 'quarto', desc = 'Next' },
      { '<localleader>rp', ':QuartoSendAbove<cr>', ft = 'quarto', desc = 'Previous' },
      { '<localleader>mi', ':MoltenInit<cr>', ft = 'quarto', desc = 'Init' },
      { '<localleader>mo', ':noautocmd MoltenEnterOutput<CR>', ft = 'quarto', desc = 'show/enter output' },
      { '<m-cr>', ':QuartoSend<cr>', ft = 'quarto', desc = 'Run Command' },
      { '<m-cr>', '<ESC>:QuartoSend<cr>', ft = 'quarto', desc = 'Run Command' },
    },
  },
}
