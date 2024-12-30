local key_local = require('core.utils').set_local
key_local('n', '<localleader>v', '<cmd>VenvSelect<cr>', 'Select Venv')

vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.wo.showbreak = '|'

vim.cmd.setlocal 'spell'
