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
    vim.b[ctx.buf].folding_enabled = true -- For keep track
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = event.buf, desc = desc })
    end

    map('n', 'gd', function()
      Snacks.picker.lsp_definitions()
    end, 'Defiinition')
    map('n', 'gD', function()
      Snacks.picker.lsp_declarations()
    end, 'Declaration')
    map('n', 'grr', function()
      Snacks.picker.lsp_references()
    end, 'References') -- update default -> QuickFix
    map('n', 'gri', function()
      Snacks.picker.lsp_implementations()
    end, 'Implementation') -- update default
    map('n', 'gy', function()
      Snacks.picker.lsp_type_definitions()
    end, 'Type Definition') -- update default
    map('n', 'gO', function()
      Snacks.picker.lsp_symbols()
    end, 'Implementation') -- update default -> QuickFix
    map('n', 'cd', function()
      vim.diagnostic.open_float { { border = 'rounded' } }
    end, 'Implementation') -- update default -> QuickFix
    map('n', 'K', function()
      vim.lsp.buf.hover { border = 'rounded', max_width = 80, max_height = 15 }
    end, 'Implementation') -- update default -> QuickFix
  end,
})
