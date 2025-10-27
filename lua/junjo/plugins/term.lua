return {
  'nvzone/floaterm',
  dependencies = 'nvzone/volt',
  opts = {
    mappings = {
      sidebar = function(buf)
        vim.keymap.set('n', '<C-h>', require('floaterm.api').switch_wins, { buffer = buf })
      end,
      term = function(buf)
        vim.keymap.set('t', '<C-n>', require('floaterm.api').new_term, { buffer = buf })
      end,
    },
  },
  cmd = 'FloatermToggle',
  keys = {
    {
      '<leader>f',
      '<cmd>FloatermToggle<cr>',
      mode = 'n',
      desc = 'Floaterm',
    },
  },
}
