-- Editor plugin

return {
  {
    enabled = true,
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets', 'L3MON4D3/LuaSnip', version = 'v2.*' },

    version = '*',
    event = { 'InsertEnter', 'CmdLineEnter' },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = 'default' },

      appearance = {
        nerd_font_variant = 'mono',
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      completion = {
        menu = { border = 'single' },
        documentation = { window = { border = 'single' }, auto_show = true, auto_show_delay_ms = 500 },
        ghost_text = { enabled = false },
        list = {
          selection = {
            preselect = function(ctx)
              return ctx.mode ~= 'cmdline' and not require('blink.cmp').snippet_active { direction = 1 }
            end,
            auto_insert = function(ctx)
              return ctx.mode ~= 'cmdline'
            end,
          },
        },
      },
      signature = { enabled = true, window = { border = 'single' } },
      snippets = { preset = 'luasnip' },
    },
    config = function(_, opts)
      require('blink-cmp').setup(opts)
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.filetype_extend('quarto', { 'markdown' })
      luasnip.filetype_extend('rmarkdown', { 'markdown' })
    end,
  },
  {
    enabled = false,
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer', -- source for text in buffer
      'hrsh7th/cmp-path', -- source for file system paths
      'saadparwaiz1/cmp_luasnip', -- for autocompletion
      'f3fora/cmp-spell',
      'hrsh7th/cmp-emoji',
      'kdheepak/cmp-latex-symbols',
      'jmbuhr/cmp-pandoc-references',
      'L3MON4D3/LuaSnip', -- snippet engine
      'rafamadriz/friendly-snippets', -- useful snippets
      'onsails/lspkind.nvim', -- vs-code like pictograms
      {
        'micangl/cmp-vimtex',
        config = function()
          require('cmp_vimtex').setup {
            additional_information = {
              info_in_menu = true,
              info_in_window = true,
              info_max_length = 60,
              match_against_info = true,
              symbols_in_menu = true,
            },
            bibtex_parser = {
              enabled = true,
            },
            search = {
              browser = 'open',
              default = 'google_scholar',
              search_engines = {
                google_scholar = {
                  name = 'Google Scholar',
                  get_url = require('cmp_vimtex').url_default_format 'https://scholar.google.com/scholar?hl=en&q=%s',
                },
                -- Other search engines.
              },
            },
          }
        end,
      },
      {
        'L3MON4D3/cmp-luasnip-choice',
        config = function()
          require('cmp_luasnip_choice').setup {
            auto_open = false, -- Automatically open nvim-cmp on choice node (default: true)
          }
        end,
      },
    },
    config = function()
      ---Check whether `check` and call action or fallback
      ---@param do_action boolean: true -> action(), false -> fallback()
      ---@param action function
      ---@param fallback function
      ---@return any: result of calling action or fallback
      local function action_or_fallback(do_action, action, fallback)
        if do_action then
          return action()
        else
          return fallback()
        end
      end

      local merge = function(a, b)
        return vim.tbl_deep_extend('force', {}, a, b)
      end

      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

      require('luasnip.loaders.from_vscode').lazy_load()
      -- for custom snippets
      require('luasnip.loaders.from_vscode').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snips' } }
      -- link quarto and rmarkdown to markdown snippets
      luasnip.filetype_extend('quarto', { 'markdown' })
      luasnip.filetype_extend('rmarkdown', { 'markdown' })

      cmp.setup {
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          -- confirm selection
          ['<C-j>'] = cmp.mapping.confirm { select = true },

          -- scroll up and down in the completion documentation
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Select the next or previous item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
          ['<C-e>'] = cmp.mapping(function(fallback)
            if luasnip.choice_active() then
              luasnip.change_choice(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-d>'] = cmp.mapping(function(fallback)
            if luasnip.choice_active() then
              luasnip.change_choice(1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        -- sources for autocompletion
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip' }, -- snippets
          { name = 'luasnip_choice' },
          { name = 'buffer' }, -- text within current buffer
          { name = 'path' }, -- file system paths
          { name = 'neorg' },
          { name = 'vimtex' }, -- file system paths
          { name = 'pandoc_references' },
          {
            name = 'latex_symbols',
            option = {
              strategy = 0, -- mixed
            },
          },
          {
            name = 'spell',
            keyword_length = 4,
            option = {
              keep_all_entries = false,
              enable_in_contex = function()
                return true
              end,
            },
          },
          {
            name = 'emoji',
          },
        },
        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = lspkind.cmp_format {
            maxwidth = 50,
            ellipsis_char = '...',
          },
        },
        window = {
          documentation = merge(cmp.config.window.bordered(), {
            max_height = 20,
            max_width = 60,
          }),
          completion = cmp.config.window.bordered(),
        },
        experimental = {
          ghost_text = { hl_group = 'Comments' },
        },
      }
    end,
  },
}
