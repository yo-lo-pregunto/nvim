local M = { servers = {}, formats = {} }

local function serv_to_lang(servers, lang, t)
  for _, server in ipairs(servers) do
    t[server] = lang
  end
  return t
end

for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath 'config' .. '/lua/langs', [[v:val =~ '\.lua$']])) do
  if file ~= 'init.lua' then
    local lang = string.gsub(file, '%.lua', '')
    M[lang] = require('langs.' .. lang)
    M.servers = serv_to_lang(M[lang].server, lang, M.servers)
    M.formats = serv_to_lang(M[lang].format or {}, lang, M.formats)
  end
end

local ensure_installed = vim.list_extend({}, vim.tbl_keys(M.servers))
ensure_installed = vim.list_extend(ensure_installed, vim.tbl_keys(M.formats))
M.ensure_installed = ensure_installed

return M
