-- Completion engine

return {
  'saghen/blink.cmp',

  event = 'InsertEnter',

  dependencies = {
    'L3MON4D3/LuaSnip',
  },

  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      menu = { border = 'rounded' },
      documentation = { auto_show = true, window = { border = 'rounded' } },
    },

    signature = {
      enabled = true,
      trigger = {
        show_on_insert = true,
      },
      window = {
        border = 'rounded',
      },
    },

    snippets = { preset = 'luasnip' },

    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },

    fuzzy = { implementation = 'prefer_rust_with_warning' },
    keymap = {
      ['<C-p>'] = {
        function()
          local session = require 'luasnip.session'
          local active_choice = session.active_choice_nodes[vim.api.nvim_get_current_buf()]
          if active_choice == nil then
            return nil
          end
          vim.schedule(function () require('luasnip').change_choice(-1) end)
          return true
        end,
        'select_prev',
        'fallback_to_mappings',
      },
      ['<C-n>'] = {
        function()
          local session = require 'luasnip.session'
          local active_choice = session.active_choice_nodes[vim.api.nvim_get_current_buf()]
          if active_choice == nil then
            return nil
          end
          vim.schedule(function () require('luasnip').change_choice(1) end)
          return true
        end,
        'select_next',
        'fallback_to_mappings',
      },
    },
  },
  opts_extend = { 'sources.default' },
}
