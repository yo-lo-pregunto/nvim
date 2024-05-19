local M = {}

function M.nmap(lhs, rhs, desc)
    vim.keymap.set('n', lhs, rhs, { silent = true, noremap = true, desc= desc, buffer = 0 })
end

function M.imap(lhs, rhs, desc)
    vim.keymap.set('i', lhs, rhs, { silent = true, noremap = true, desc= desc, buffer = 0 })
end

return M
