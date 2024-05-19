-- Config a terminal buffer
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = { '*' },
  callback = function(_)
    vim.cmd.setlocal 'nonumber'
    vim.cmd.setlocal 'norelativenumber'
  end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'InsertCharPre' }, {
    pattern = { '*.tex' },
    callback = function ()
        vim.schedule(function ()
            local pos = vim.api.nvim_win_get_cursor(0)
            local lim = tonumber(vim.opt.colorcolumn._value or '80')
            if pos[2] >= lim then
                local line = vim.api.nvim_get_current_line()
                local index = line:reverse():find(' ')
                if index ~= 1 then
                    local last_word = line:sub(-index + 1, -1)
                    vim.api.nvim_buf_set_lines(0, pos[1] - 1, pos[1], true, {
                        line:sub(1, -index-1), last_word
                    })
                    vim.api.nvim_win_set_cursor(0, { pos[1] + 1, last_word:len() })
                else
                    vim.api.nvim_buf_set_lines(0, pos[1] - 1, pos[1], true, {
                        line, ''
                    })
                    vim.api.nvim_win_set_cursor(0, { pos[1] + 1, 1 })
                end
            end
        end)
    end,
})
