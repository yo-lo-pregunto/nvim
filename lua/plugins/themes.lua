local function add_themes(themes)
  local t = {}
  for i, v in ipairs(themes) do
    t[i] = { v, lazy = false, priority = 1000 }
  end
  return t
end

return add_themes({
  "tiagovla/tokyodark.nvim",
  "folke/tokyonight.nvim",
  'AlexvZyl/nordic.nvim',
  'projekt0n/github-nvim-theme',
  "bluz71/vim-moonfly-colors",
  'jacoborus/tender.vim',
})
