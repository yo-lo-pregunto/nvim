return {
  'stevearc/oil.nvim',
  version = '*',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ['q'] = {
        callback = function()
          vim.schedule(function()
            vim.cmd.write()
            require('oil').close()
          end)
        end,
        mode = 'n',
        desc = 'Save and Close',
      },
    },
    float = {
      max_height = 0.5,
      max_width = 0.5,
    },
  },
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  keys = {
    -- Windows creation
    { '<leader>-', '<C-W>s<cmd>Oil<cr>', desc = 'Split Below' },
    { '<leader>|', '<C-W>v<cmd>Oil<cr>', desc = 'Split Right' },
    { '-', '<cmd> Oil --float<cr>', desc = 'Explorer' },
  },
}
