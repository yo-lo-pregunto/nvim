return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      vim.opt.timeout = true
      vim.opt.timeoutlen = 300
      local wk = require 'which-key'
      wk.setup(opts)
      wk.add {
        { '<leader>g', group = 'Git' },
        { '<leader>l', group = 'Lsp' },
        { '<leader>s', group = 'Search' },
        { '<leader>x', group = 'Exit' },
        { '<leader><space>', group = 'Debug' },
        -- { "<leader>h", group = "Harpoon" },
        -- { "<leader>n", group = "Node" },
        -- { "<leader>o", group = "Open" },
        -- { "<leader>b", group = "Buffer" },
        -- { "\\",        group = "Local Maps" },
      }
    end,
  },
}
