local set_local = require('core.utils').set_local
local n = vim.g.personal_options.neorg

local function export_path()
  local md_file = vim.fn.expand '%:t:r' .. '.md'
  local path = n.dirs.markdown .. '/' .. md_file
  local cmd = 'Neorg export to-file ' .. path
  print('Exporting file to ' .. path)
  vim.cmd(cmd)
end

vim.cmd.setlocal 'spell'
vim.cmd.setlocal 'conceallevel=2'

set_local('i', '<c-l>', '<ESC><Plug>(neorg.telescope.insert_link)', 'Insert Link')
set_local('n', '<localleader>e', '<cmd>Neorg toc<cr>', 'TOC')
set_local('n', '<localleader>x', export_path, 'Export')
set_local('n', '<localleader>i', '<cmd>Neorg inject-metadata<cr>', 'Inject md')
