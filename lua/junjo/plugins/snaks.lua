return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    input = { enabled = true },

    --- @type snacks.picker.Config
    picker = {
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
          }
        }
      }
    },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
  },
  keys = {
    { '<leader>S', function() Snacks.picker() end, desc = 'Snacks'},
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>sC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    { "<leader>sc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config" },
    { '<leader>sf', function() Snacks.picker.smart() end, desc = 'Files'},
    { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep'},
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help'},
    { '<leader>sr', function() Snacks.picker.resume() end, desc = 'Resume'},
    { "<leader>sp", function() Snacks.picker.projects({ dev = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')}) end, desc = "Package" },
    { '<leader>sw', function() Snacks.picker.grep_word() end, mode = {'n', 'x' }, desc = 'Word' },
  }
}
