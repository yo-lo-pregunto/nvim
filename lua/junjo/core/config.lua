-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Diagnostics
vim.diagnostic.config {
  underline = false,
  virtual_text = false,
  virtual_lines = {
    severity = vim.diagnostic.severity.ERROR,
    current_line = true,
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
      [vim.diagnostic.severity.INFO] = 'Statement',
      [vim.diagnostic.severity.HINT] = 'Statement',
    },
  },
  float = {
    border = 'rounded',
    source = true,
  },
}

-- Python
local paths = { '~/miniconda3/envs/neovim/bin', '~/.virtualenvs/neovim/bin' }

for _, path in ipairs(paths) do
  local full_path = vim.fn.expand(path)
  local info = vim.uv.fs_stat(full_path)

  if info and info.type == 'directory' then
    vim.g.python3_host_prog = full_path .. '/python'
    vim.fn.setenv('PATH', full_path .. ':' .. vim.fn.getenv 'PATH')
    break
  end
end
