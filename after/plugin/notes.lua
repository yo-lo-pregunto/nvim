local ft = vim.g.my_notes_fts

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

local function run_or_toggletodo()
  if is_code_chunk() then
    vim.cmd [[QuartoSend]]
  else
    vim.cmd [[MkdnToggleToDo]]
  end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = ft,
  callback = function(ctx)
    vim.keymap.set({ 'n', 'i' }, '<m-a>', insert_py_chunk, { buffer = ctx.buf, silent = true })
    vim.keymap.set('n', '<m-cr>', run_or_toggletodo, { buffer = ctx.buf, silent = true })
    vim.keymap.set('v', '<m-cr>', '<cmd>MkdnToggleToDo<cr>', { buffer = ctx.buf, silent = true })
    vim.keymap.set('i', '<m-cr>', '<esc><cmd>QuartoSend<cr>', { buffer = ctx.buf, silent = true })
  end,
})
