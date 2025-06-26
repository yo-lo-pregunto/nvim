local opt = vim.opt

-- Try :options to toggle the settings!

opt.number = true
opt.relativenumber = true

-- Tabs & Indentation
opt.smarttab = true
opt.smartindent = true
opt.expandtab = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2

-- Backups files
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.inccommand = 'split'

-- Visual
opt.termguicolors = true
opt.background = 'dark'
opt.signcolumn = 'yes'
opt.scrolloff = 999
opt.wrap = false
opt.virtualedit = 'block'

-- Split Windows
opt.splitright = true
opt.splitbelow = true

opt.updatetime = 50
