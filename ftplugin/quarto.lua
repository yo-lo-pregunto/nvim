local tools = require'config.tools'

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

vim.cmd.setlocal 'spell'

-- Normal Mode
tools.nmap("<localleader>a", ':QuartoActivate<cr>', 'Activate')
tools.nmap("<localleader>p", ':QuartoPreview<cr>', 'Preview')
tools.nmap("<localleader>q", ':QuartoClosePreview<cr>', 'Close')
tools.nmap("<localleader>rs", ':QuartoSend<cr>', 'Send')
tools.nmap("<localleader>ra", ':QuartoSendAll<cr>', 'All')
tools.nmap("<localleader>rn", ':QuartoSendBelow<cr>', 'Next')
tools.nmap("<localleader>rp", ':QuartoSendAbove<cr>', 'Previous')
tools.nmap("<localleader>s", ':VenvSelect<cr>', 'Select Env')
tools.nmap("<localleader>mi", ':MoltenInit<cr>', 'Init')
tools.nmap("<localleader>mo", ":noautocmd MoltenEnterOutput<CR>", "show/enter output" )
tools.nmap("<m-a>", insert_py_chunk, 'Insert Python chunk')
tools.nmap("<m-cr>", ":QuartoSend<cr>", 'Run Command')

-- Insert Mode
tools.imap("<m-a>", insert_py_chunk, 'Insert Python chunk')
