local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", 'kj', '<ESC>', { desc = 'Exist insert mode' })
