local ft = vim.g.my_notes_fts

return {
  'HakonHarnes/img-clip.nvim',
  ft = { 'markdown', 'quarto', 'latex', 'norg' },
  cmd = 'PasteImage',
  opts = {
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
  keys = {
    { '<localleader>p', '<cmd>PasteImage<cr>', ft = ft, desc = 'Paste Image' },
  },
}
