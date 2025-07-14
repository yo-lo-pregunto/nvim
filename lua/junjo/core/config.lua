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
