-- Editor plugin

return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "VeryLazy",
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next todo comment",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous todo comment",
    },
  },
  opts = {
    keywords = { -- keywords recognized as todo comments
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = "󱎫 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO", "HINT" } },
    },
    signs = false,
  },
}

-- TODO: test this line whether the highlighting is done correctly.
-- PERF: fully optimized
-- NOTE: adding a note
-- HACK: this should be implemented more carefully
-- FIX: this needs fixing
-- HINT: hoge
