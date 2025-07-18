--- Walk over all files in a directory and return file names without extension
--- @param dir string: Absolute path to the folder (e.g., "/home/user/.config/nvim/lua/lsp")
--- @return table: List of file names (no extension)
local function get_lsp_file_names(dir)
  local stat = vim.uv or vim.loop
  local result = {}

  local function scan(path)
    local fd = stat.fs_scandir(path)
    if not fd then return end

    while true do
      local name, t = stat.fs_scandir_next(fd)
      if not name then break end

      if t == "file" then
        local file = name:match("^(.*)%.%w+$") or name -- strip extension
        table.insert(result, file)
      end
    end
  end

  scan(dir)
  return result
end

local servers = get_lsp_file_names(vim.fn.stdpath('config') .. '/lsp/')

for _, server in ipairs(servers) do
  vim.lsp.config(server, {})
  vim.lsp.enable(server, true)
end
