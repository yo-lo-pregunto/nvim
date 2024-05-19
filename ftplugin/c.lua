local tools = require'config.tools'

tools.nmap('<localleader>g', '<cmd>CMakeGenerate<CR>', 'Generate')
tools.nmap('<localleader>q', '<cmd>CMakeClose<CR>',  'Close')
