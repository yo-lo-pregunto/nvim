-- Enable Tree-sitter for the default languages
-- From nvim v0.11.0 treesitter plugin just manage installing, updating, and
-- removing parsers.
local languages = { 'rust', 'c', 'lua', 'python', 'markdown', 'bash' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = languages,
  callback = function(ctx)
    local win = vim.api.nvim_get_current_win()

    -- Highlight
    local ft = vim.bo.filetype
    local lang = vim.treesitter.language.get_lang(ft)

    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(ctx.buf, lang)
    end

    -- Folding
    vim.wo[win].foldenable = false
    vim.wo[win].foldmethod = 'expr'
    vim.wo[win].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.b[ctx.buf].folding_enabled  = true -- For keep track
  end
})


