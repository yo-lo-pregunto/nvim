-- UI plugin

return {
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'BufferLineGoToBuffer', 'BufferLineCycleNext', 'BufferLineCyclePrev', 'BufferLinePick' },
    opts = {
      options = {
        close_command = 'bd %d',
        right_mouse_command = 'bd %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = nil,
        buffer_close_icon = '',
        close_icon = '',
        max_name_length = 30,
        max_prefix_length = 30,
        tab_size = 12,
        diagnostics = false,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = { '', '' },
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        custom_filter = function(buf, _)
          local bufname = vim.fn.bufname(buf) or ''
          if vim.endswith(bufname, '.vira_prompt') then
            return false
          end
          return string.len(bufname) ~= 0
        end,
        sort_by = function(a, b) ---@diagnostic disable-line
          -- sort by modified time (newer to left)
          local mod_a = vim.loop.fs_stat(a.path)
          local mod_b = vim.loop.fs_stat(b.path)
          if mod_a == nil and mod_b == nil then
            return a.name > b.name
          elseif mod_a == nil then
            return true
          elseif mod_b == nil then
            return false
          end
          return mod_a.mtime.sec > mod_b.mtime.sec
        end,
      },
      highlights = {
        tab_selected = {
          link = 'Title',
        },
      },
    },
  },
}
