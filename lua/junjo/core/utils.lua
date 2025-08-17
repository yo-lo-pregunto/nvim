local M = {}

function M.get_os()
  local osnames = {
    ['Darwin'] = 'macos',
    ['Linux'] = 'linux',
  }
  local f = io.popen 'uname -s'
  local osname
  if f then
    osname = f:read()
    f:close()
  else
    return 'windows'
  end

  if osname ~= nil then
    return osnames[osname]
  end
end

return M
