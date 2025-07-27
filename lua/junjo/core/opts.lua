local opt = vim.opt

-- Try :options to toggle the settings!

if vim.g.neovim_mode == 'notes' then
  opt.number = false
  opt.relativenumber = false
  opt.textwidth = 60
  opt.signcolumn = 'no'
else
  opt.number = true
  opt.relativenumber = true
  opt.textwidth = 100
  opt.signcolumn = 'yes'
end
opt.colorcolumn = '100'

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
opt.scrolloff = 8
opt.wrap = false
opt.virtualedit = 'block'

-- Split Windows
opt.splitright = true
opt.splitbelow = true

opt.updatetime = 50

opt.cursorline = true
