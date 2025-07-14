return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
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
}
