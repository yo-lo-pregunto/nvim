vim.lsp.enable({
  'clangd',
  'lua_ls'
})

-- Diagnostics
vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  virtual_lines = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})
