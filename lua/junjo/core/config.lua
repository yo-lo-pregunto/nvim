-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Diagnostics
vim.diagnostic.config {
  underline = true,
  virtual_text = false,
  virtual_lines = false,
  severity_sort = true,
  signs = false,
  float = {
    border = 'rounded',
    source = true,
  },
}
