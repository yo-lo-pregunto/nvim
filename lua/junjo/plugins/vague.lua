return {
  "vague2k/vague.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    vim.cmd [[colorscheme vague]]
  end,
}
