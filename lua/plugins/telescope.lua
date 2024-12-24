-- Editor plugin

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ['<ESC>'] = actions.close,
              ['<leftMouse>'] = actions.select_default,
              ['<ScrollWheelDown>'] = actions.move_selection_next,
              ['<ScrollWheelUp>'] = actions.move_selection_previous,
            }
          }
        },
        pickers = {
          find_files = {
            theme = 'ivy'
          },
          help_tags = {
            theme = 'ivy'
          },
          resume = {
            theme = 'ivy'
          },
          grep_string = {
            theme = 'ivy'
          },
          current_buffer_fuzzy_find = {
            theme = 'ivy'
          },
        },
        extensions = {
          fzf = {},
        }
      })
      telescope.load_extension("fzf")
    end,
    cmd = 'Telescope',
    keys = function()
      local b = require('telescope.builtin')

      local function live_grep_open_files()
        b.live_grep({
          grep_open_files = true,
          prompt_tilte = 'Live Grep in Open Files',
        })
      end

      return {
        { "<leader>so", function() live_grep_open_files() end,        desc = "Open Files" },
        { "<leader>sf", function() b.find_files() end,                desc = "Files" },
        { "<leader>sh", function() b.help_tags() end,                 desc = "Help" },
        { "<leader>sr", function() b.resume() end,                    desc = "Resume" },
        { "<leader>sw", function() b.grep_string() end,               desc = "Word" },
        { "<leader>s/", function() b.current_buffer_fuzzy_find() end, desc = "Buffer" },
        {
          "<leader>sg",
          function()
            b.grep_string({ search = vim.fn.input('Grep > '), })
          end,
          desc = "Grep"
        },
        {
          '<leader>s,',
          function()
            b.find_files({
              cwd = vim.fn.stdpath('config')
            })
          end,
          desc = 'Config'
        },
        {
          "<leader>sp",
          function()
            b.find_files({
              cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
            })
          end,
          desc = 'MultiGrep'
        },
      }
    end
  }
}
