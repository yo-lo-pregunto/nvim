-- Editor plugin

return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',

    version = '*',
    event = 'InsertEnter',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = 'default', cmdline = { preset = 'enter' } },

      appearance = {
        nerd_font_variant = 'mono',
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      completion = {
        menu = { border = 'single' },
        documentation = { window = { border = 'single' }, auto_show = true, auto_show_delay_ms = 500 },
        ghost_text = { enabled = true },
        list = {
          selection = function(ctx)
            return ctx.mode == 'cmdline' and 'auto_insert' or 'preselect'
          end,
        },
      },
      signature = { enabled = true, window = { border = 'single' } },
    },
    opts_extend = { 'sources.default' },
  },
}
