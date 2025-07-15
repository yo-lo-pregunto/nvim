local function shorter_name(filename)
  return filename:gsub('/bin/python', ''):match '([^/]+)$'
end

return {
  {
    'linux-cultist/venv-selector.nvim',
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    ft = { 'python', 'quarto' },
    keys = {
      { '<leader>cv', '<cmd>VenvSelect<cr>', desc = 'PyVenv', ft = { 'python', 'quarto' } },
    },
    ---@type venv-selector.Config
    opts = {
      options = {
        on_telescope_result_callback = shorter_name,
        activate_venv_in_terminal = true,
        notify_user_on_venv_activation = true,
        on_venv_activate_callback = function()
          local command_run = false

          local function run_shell_command()
            local source = require('venv-selector').source() or ''
            local venv = require('venv-selector').venv()
            venv = vim.fn.fnamemodify(venv, ':t')

            if source == 'miniconda_envs' and command_run == false then
              local command = 'conda activate ' .. venv
              vim.api.nvim_feedkeys(command .. '\n', 'n', false)
              command_run = true
            end
          end

          vim.api.nvim_create_augroup('TerminalCommands', { clear = true })

          vim.api.nvim_create_autocmd('TermEnter', {
            group = 'TerminalCommands',
            pattern = '*',
            callback = run_shell_command,
          })
        end,
      },
      search = {
        miniconda_envs = {
          command = "$FD 'python$' ~/miniconda3/envs/*/bin --full-path --color never --exclude ipython",
          type = 'anaconda',
        },
      },
    },
  },
}
