local home = os.getenv 'HOME'
local neorg_home = home .. '/Neorg'

vim.g.personal_options = {
  date_format = '%A-%d-%b-%Y',
  neorg = {
    workspaces = { notes = neorg_home .. '/notes' },
    default_workspace = 'notes',
    home = neorg_home,
    dirs = {
      images = neorg_home .. '/images',
      markdown = neorg_home .. '/markdown',
    },
  },
}
