return {
  { -- paste an image from the clipboard or drag-and-drop
    'HakonHarnes/img-clip.nvim',
    ft = { 'markdown', 'quarto', 'latex', 'norg' },
    cmd = 'PasteImage',
    opts = {
      default = {
        dir_path = function()
          if vim.bo.filetype == 'norg' then
            return vim.g.personal_options.neorg.dirs.images
          else
            return 'images'
          end
        end,
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = '![$CURSOR]($FILE_PATH)',
          drag_and_drop = {
            download_images = false,
          },
        },
        quarto = {
          url_encode_path = true,
          template = '![$CURSOR]($FILE_PATH)',
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
  },
  {
    '3rd/image.nvim',
    ft = { 'norg', 'markdown' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      backend = 'kitty',
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = true,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          filetypes = { 'markdown', 'quarto' }, -- markdown extensions (ie. quarto) can go here
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = true,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          filetypes = { 'norg' },
        },
      },
      tmux_show_only_in_active_window = true,
    },
  },
  {
    'mistricky/codesnap.nvim',
    build = 'make build_generator',
    cmd = { 'CodeSnap', 'CodeSnapSave' },
    opts = {
      save_path = '~/Pictures',
      has_breadcrumbs = false,
      bg_theme = 'bamboo',
      watermark = '',
      bg_color = '#535c68',
      bg_x_padding = 61,
      bg_y_padding = 41,
    },
    keys = {
      { '<leader>p', ':CodeSnap<cr>', mode = { 'v', 'x' }, desc = 'Code snapshot to clipboard' },
      { '<leader>S', ':CodeSnapSave<cr>', mode = { 'v', 'x' }, desc = 'Save code snapshot' },
    },
  },
}
