---Execute an action on not current grup buffers
---@param action group_actions | fun(b: bufferline.Buffer)
local function unfocused_groups_action(action)
  local state = require 'bufferline.state'
  local commands = require 'bufferline.commands'
  local groups = require 'bufferline.groups'
  local utils = require 'bufferline.utils'

  -- 1. Get current Element
  local _, element = commands.get_current_element_index(state)

  -- 2. Get current Group
  if not element or not element.group then
    return
  end
  local current_group = groups.get_by_id(element.group)

  -- 3. Get groups
  local unfocused_groups = vim.tbl_filter(function(group)
    return group ~= current_group.name
    ---@diagnostic disable-next-line:missing-parameter
  end, groups.complete())

  -- 4. Do something
  utils.for_each(function(group)
    groups.action(group, action)
  end, unfocused_groups)
end

return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      close_command = function(n)
        Snacks.bufdelete(n)
      end,
      right_mouse_command = function(n)
        Snacks.bufdelete(n)
      end,
      mode = 'buffers',
      indicator = {
        style = 'underline',
      },
      diagnostics = false,
      sort_by = 'insert_at_end',
      separator_style = 'slope',
      groups = {
        items = {
          {
            name = 'Project',
            highlight = { underline = true },
            matcher = function(buf)
              local cwd = vim.fn.getcwd()
              return vim.startswith(buf.path, cwd)
            end,
          },
          {
            name = 'Others',
            matcher = function(buf)
              local cwd = vim.fn.getcwd()
              return vim.startswith(buf.path, cwd) == false
            end,
          },
        },
      },
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)
    require('bufferline.groups').builtin.pinned:with { icon = '󰐃 ' }
  end,
  keys = {
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '<C-p>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<C-n>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    {
      '<leader>bO',
      function()
        Snacks.bufdelete.other()
      end,
      desc = 'Keep current buf',
    },
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
    {
      '<leader>bt',
      function()
        unfocused_groups_action 'toggle'
      end,
      desc = 'Toggle Groups',
    },
    {
      '<leader>bc',
      function()
        unfocused_groups_action 'close'
      end,
      desc = 'Groups Close',
    },
  },
}
