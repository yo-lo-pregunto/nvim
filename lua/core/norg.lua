local function imports()
  return require 'luasnip', require 'neorg.modules.external.templates.default_snippets'
end

---Calculate relative dates based on a given date
---@param date_str string # Anchor date
---@param delta_date integer # Relative days
---@return string # Relative
local function calculate_date(date_str, delta_date)
  -- Define the format for parsing and formatting
  local format = vim.g.personal_options.date_format

  -- Parse the input date into a Lua time object
  local _, day, month_str, year = date_str:match '(%a+)-(%d+)-(%a+)-(%d+)'
  -- stylua: ignore
  local months = {
    Jan = 1, Feb = 2, Mar = 3, Apr = 4, May = 5, Jun = 6,
    Jul = 7, Aug = 8, Sep = 9, Oct = 10, Nov = 11, Dec = 12,
  }
  local month = months[month_str]

  -- Create the time object
  local time = os.time { year = tonumber(year), month = month, day = tonumber(day), hour = 12 } -- Set hour to avoid DST issues

  return os.date(format, time + 86400 * delta_date)
end

local function convert_date_format(date_str)
  -- Parse the input date string into a time table
  local year, month, day = date_str:match '(%d+)%-(%d+)%-(%d+)'
  local time = os.time { year = tonumber(year), month = tonumber(month), day = tonumber(day), hour = 12 }

  -- Format the time table to the new format
  local new_format = '%A-%d-%b-%Y'
  return os.date(new_format, time)
end

return {
  TEMP_TITLE = function()
    local ls, m = imports()
    return ls.function_node(function()
      return convert_date_format(m.file_title())
    end)
  end,
  TICKET_FOLDER = function()
    local ls, m = imports()
    return ls.function_node(function()
      local file = m.file_title()
      print 'todo bien'
      return '/ ~/tickets/' .. file .. '/'
    end)
  end,
  COMMUNITY_URL = function()
    local ls, _ = imports()
    return ls.insert_node(1, 'https://community.nxp.com')
  end,
  JIRA_URL = function()
    local ls, _ = imports()
    return ls.insert_node(1, 'https://jira.sw.nxp.com')
  end,
  IMX_BOARD = function()
    local ls, _ = imports()
    return ls.insert_node(1, '8MPlus')
  end,
  IMX_OS = function()
    local ls, _ = imports()
    return ls.insert_node(1, 'imx-android-12.0.0')
  end,
  IMX_CUSTOMER = function()
    local ls, _ = imports()
    return ls.insert_node(1, 'TIC')
  end,
  YES_FILENAME = function()
    local ls, m = imports()
    return ls.text_node(calculate_date(m.file_title(), -1))
  end,
  TOM_FILENAME = function()
    local ls, m = imports()
    return ls.text_node(calculate_date(m.file_title(), 1))
  end,
}
