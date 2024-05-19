local M = {}

for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config')..'/lua/servers', [[v:val =~ '\.lua$']])) do
    if file ~= "init.lua" then
        local lang = string.gsub(file, '%.lua', '')
        M = vim.tbl_extend("error", M, require("servers."..lang))
    end
end

return M
