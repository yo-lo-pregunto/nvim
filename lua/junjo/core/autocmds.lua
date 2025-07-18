-- Enable Tree-sitter for the default languages
-- From nvim v0.11.0 treesitter plugin just manage installing, updating, and
-- removing parsers.
local languages = { 'rust', 'c', 'lua', 'python', 'markdown', 'bash' }

local is_code_chunk = function()
  local current, _ = require('otter.keeper').get_current_language_context()
  if current then
    return true
  else
    return false
  end
end

--- Insert code chunk of given language
--- Splits current chunk if already within a chunk
--- @param lang string
local insert_code_chunk = function(lang)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'n', true)
  local keys
  if is_code_chunk() then
    keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
  else
    keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
  end
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end

local insert_py_chunk = function()
  insert_code_chunk 'python'
end

-- Highlight when yanking text
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
  pattern = {
    'PlenaryTestPopup',
    'dbout',
    'gitsigns-blame',
    'help',
    'qf',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'quarto', 'markdown' },
  callback = function(ctx)
    vim.keymap.set({ 'n', 'i' }, '<m-a>', insert_py_chunk, { buffer = ctx.buf, silent = true })
  end,
})

-- Enable Tree-sitter Highlight and Folding
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
    map('n', '<leader>cd', function()
      vim.diagnostic.open_float { { border = 'rounded' } }
    end, 'Diagnostic') -- update default -> QuickFix
    map('n', '<leader>cd', function()
      vim.diagnostic.open_float { { border = 'rounded' } }
    end, 'Diagnostic') -- update default -> QuickFix
    map('n', '<leader>cD', function()
      Snacks.picker.diagnostics()
    end, 'Project Diagnostic') -- update default -> QuickFix
    map('n', 'K', function()
      vim.lsp.buf.hover { border = 'rounded', max_width = 80, max_height = 15 }
    end, 'Hover') -- update default -> QuickFix

    map('n', '<leader>ca', function()
      vim.lsp.buf.code_action()
    end, 'Code Actions') -- update default -> QuickFix

    -- Highlight word under cursor
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      Snacks.toggle.inlay_hints():map '<leader>cH'
    end
  end,
})
