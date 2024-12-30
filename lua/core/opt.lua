local opt = vim.opt

opt.number = true -- Linew number
opt.relativenumber = true -- Show absolute line number on cursor line

opt.wrap = false

opt.cursorline = true
opt.colorcolumn = '80'

-- Tabs & indentation
opt.smarttab = true -- Default value is true
opt.smartindent = true
opt.expandtab = true
opt.shiftwidth = 4 -- Uses 4 spaces when indent
opt.tabstop = 4 -- 4 spaces per tab
opt.autoindent = true -- Copy indent from current line when starting new one

-- Search
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- If you include mised case in your search assumes you want case-sensitve
opt.incsearch = true -- Show you live match. Not recommended on slow computers.

opt.virtualedit = 'block' -- When Visual Block uses cells
opt.inccommand = 'split' -- Show a quickfix list with live changes

-- Appearance
opt.background = 'dark' -- Colorschemes that can be light or dark will be set to dark
opt.termguicolors = true -- Nee a true color terminal
opt.signcolumn = 'yes' -- Show sign column so that text doesn't shift
opt.conceallevel = 0 -- Latex require for fancy fonts

-- Scroll
opt.scrolloff = 10 -- Have at leat 10 lines above or below the cursor

-- Splits
opt.splitright = true -- Split vertical window to the right
opt.splitbelow = true -- Split horizontal window to the bottom

-- Times
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.pumheight = 7 -- Number of items in pop-up menu

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list''
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- NVIM in its own venv
vim.g.python3_host_prog = vim.fn.expand '~/miniconda3/envs/neovim/bin/python3'
vim.fn.setenv('PATH', '/Users/yo-lo-pregunto/miniconda3/envs/neovim/bin/' .. ':' .. vim.fn.getenv 'PATH')
