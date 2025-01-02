local M = {}

-- Store the buffer ID
M.scratch_buf = nil

-- Create or reuse the scratch buffer
function M.create_scratch_buffer()
  if M.scratch_buf and vim.api.nvim_buf_is_valid(M.scratch_buf) then
    -- Reuse the existing buffer
    return M.scratch_buf
  end

  -- Save the current window to return focus later
  local current_window = vim.api.nvim_get_current_win()

  -- Create a new buffer
  M.scratch_buf = vim.api.nvim_create_buf(false, false)

  -- Open the buffer in a vertical split
  vim.cmd 'vsplit'
  local scratch_window = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(scratch_window, M.scratch_buf)

  -- Set buffer options
  vim.api.nvim_buf_set_option(M.scratch_buf, 'buftype', 'nofile') -- Unlisted buffer
  vim.api.nvim_buf_set_option(M.scratch_buf, 'bufhidden', 'wipe') -- Remove on close
  vim.api.nvim_buf_set_option(M.scratch_buf, 'modifiable', true) -- Allow writing content
  vim.api.nvim_buf_set_option(M.scratch_buf, 'readonly', false) -- Allow modification

  -- Return focus to the original window
  vim.api.nvim_set_current_win(current_window)

  return M.scratch_buf
end

-- Append data (string or table) to the scratch buffer
function M.dump(data)
  -- Ensure the scratch buffer exists
  local buf = M.create_scratch_buffer()

  -- Convert table data to a string if necessary
  if type(data) == 'table' then
    data = vim.inspect(data)
  elseif type(data) ~= 'string' then
    data = tostring(data)
  end

  -- Get current lines in the buffer
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  -- Append the new data
  for _, line in ipairs(vim.split(data, '\n')) do
    table.insert(lines, line)
  end

  -- Update the buffer content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

return M
