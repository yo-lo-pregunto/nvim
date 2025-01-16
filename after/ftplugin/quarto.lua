local key_local = require('core.utils').set_local
key_local('n', '<localleader>v', '<cmd>VenvSelect<cr>', 'Select Venv')

vim.cmd.setlocal 'wrap'
vim.cmd.setlocal 'linebreak'
vim.cmd.setlocal 'breakindent'
vim.cmd.setlocal 'showbreak=|'
vim.cmd.setlocal 'spell'
