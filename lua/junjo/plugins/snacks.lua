return {
  'folke/snacks.nvim',
  version = '*',
  priority = 1000,
  lazy = false,

  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = ' ', key = 'e', desc = 'Explorer', action = ':Oil' },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = '', key = 'G', desc = 'Git', action = ':Neogit' },
          { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
    },
    input = { enabled = true },
    toggle = { enabled = true },
    styles = {
      snacks_image = {
        relative = 'editor',
        col = -1,
      },
    },
    image = {
      enabled = require('junjo.core.utils').get_os() == 'macos',
      doc = {
        enabled = true,
        inline = vim.g.neovim_mode == 'notes' and true or false,
        flaot = true,
        max_width = vim.g.neovim_mode == 'notes' and 60 or 60,
        max_height = vim.g.neovim_mode == 'notes' and 30 or 30,
      },
    },

    --- @type snacks.picker.Config
    picker = {
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
          },
        },
      },
    },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
  },
  keys = {
    {
      '<leader>S',
      function()
        Snacks.picker()
      end,
      desc = 'Snacks',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
    {
      '<leader>sc',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Config',
    },
    {
      '<leader>sf',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Files',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>sp',
      function()
        Snacks.picker.projects { dev = vim.fs.joinpath(vim.fn.stdpath 'data', 'lazy') }
      end,
      desc = 'Package',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      mode = { 'n', 'x' },
      desc = 'Word',
    },
    {
      'z=',
      function()
        Snacks.picker.spelling()
      end,
      desc = 'Spelling Suggestions',
    },
  },
}
