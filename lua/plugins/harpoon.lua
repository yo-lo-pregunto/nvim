return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()
    end,
    keys = {
      {
        '<leader>a',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'Harpoon Add',
      },
      {
        '<leader>e',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'Harpoon Menu',
      },
      {
        '<leader>j',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'Harpoon 1',
      },
      {
        '<leader>k',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'Harpoon 2',
      },
      {
        '<leader>i',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'Harpoon 3',
      },
      {
        '<leader>,',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'Harpoon 4',
      },
    },
  },
}
