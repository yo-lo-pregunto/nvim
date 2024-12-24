local M = { servers = {} }

for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/langs', [[v:val =~ '\.lua$']])) do
  if file ~= "init.lua" then
    local lang = string.gsub(file, '%.lua', '')
    M[lang] = require("langs." .. lang)
    local k = M[lang].server
    local v = lang
    local t = { [k] = v }
    M.servers = vim.tbl_extend('force', M.servers, t)
  end
end

return M
