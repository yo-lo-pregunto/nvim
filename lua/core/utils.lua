local M = {}

M.set_key = function(mode, lhs, rhs, opt)
  local opts = vim.tbl_extend('force', { silent = true, noremap = true }, opt or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

M.set_local = function(mode, lhs, rhs, desc)
  M.set_key(mode, lhs, rhs, { desc = desc, buffer = true })
end

return M
