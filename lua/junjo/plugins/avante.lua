return{
  "yetone/avante.nvim",
  enabled = require('junjo.core.utils').get_os() == 'macos',
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    provider = "claude",
    providers = {
      claude = {
        model = 'claude-3-5-haiku-20241022'
      },
    },
    input = {
      provider = 'snacks',
      provider_opts = {
        title = 'Avante Input',
      }
    },
    file_selector = {
      provider = 'snacks'
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "HakonHarnes/img-clip.nvim",
      'MeanderingProgrammer/render-markdown.nvim',
  },
}
