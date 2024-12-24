-- Editor plugin

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      shading_factor = 0,
      open_mapping = nil,
      on_create = function(term)
        local venv_path = require('venv-selector').venv()

        if venv_path == nil then
          return
        end

        local venv = venv_path:match '([^/]+)$'

        vim.fn.chansend(term.job_id, { 'conda activate ' .. venv .. ' && clear', '' })
      end,
    },
    keys = {
      { '<leader>t', '<cmd>ToggleTerm<cr>', desc = 'Terminal' },
    },
    cmd = 'ToggleTerm',
  },
}
