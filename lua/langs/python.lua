return {
  plugins = {
    {
      "linux-cultist/venv-selector.nvim",
      dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
      },
      lazy = true,
      branch = "regexp",
      config = function()
        -- This function gets called by the plugin when a new result from fd is received
        -- You can change the filename displayed here to what you like.
        -- Here in the example for linux/mac we replace the home directory with '~' and remove the /bin/python part.
        local function shorter_name(filename)
          return filename:gsub("/bin/python", ""):match("([^/]+)$")
        end

        require("venv-selector").setup({
          settings = {
            options = {
              -- If you put the callback here as a global option, its used for all searches (including the default ones by the plugin)
              on_telescope_result_callback = shorter_name,
              activate_venv_in_terminal = true,
              notify_user_on_venv_activation = true,
              debug = true,
            },
            search = {
              miniconda_envs = {
                command = "$FD 'python$' ~/miniconda3/envs/*/bin --full-path --color never --exclude ipython",
                type = "anaconda",
              }
            },
          }
        })
      end,
      keys = {
        { "<localleader>v", "<cmd>VenvSelect<cr>" },
      },
    },
  },
  server = 'pyright',
  opts = {
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = false,
        }
      }
    }
  },
}
