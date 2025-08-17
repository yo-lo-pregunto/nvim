vim.g.my_notes_fts = { 'quarto', 'markdown' }

vim.g.neovim_mode = vim.env.NEOVIM_MODE or "default"
vim.g.running_on = require('junjo.core.utils').get_os()

require 'junjo.core'
