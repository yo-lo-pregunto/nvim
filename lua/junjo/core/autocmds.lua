-- Enable Tree-sitter for the default languages
-- From nvim v0.11.0 treesitter plugin just manage installing, updating, and
-- removing parsers.
local languages = { 'rust', 'c', 'lua', 'python', 'markdown', 'bash', 'quarto', 'cpp' }

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
    'molten_output',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        local ft = vim.bo[event.buf].filetype
        if ft ~= 'molten_output' then
          pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
        end
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = vim.g.my_notes_fts,
  callback = function ()
    vim.opt_local.colorcolumn = ""
  end
})

vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = function ()
    vim.g.root_cwd = vim.fn.getcwd()
  end
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
    vim.wo[win].foldlevel = 1
  end,
})

-- ------------------------------------------------------------------------------------------------
-- LSP
-- ------------------------------------------------------------------------------------------------
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

-- ------------------------------------------------------------------------------------------------
-- Snippets
-- ------------------------------------------------------------------------------------------------

local current_nsid = vim.api.nvim_create_namespace 'LuaSnipChoiceListSelections'
local current_win = nil

local function window_for_choiceNode(choiceNode)
  local buf = vim.api.nvim_create_buf(false, true)
  local buf_text = {}
  local row_selection = 0
  local row_offset = 0
  local text
  for _, node in ipairs(choiceNode.choices) do
    text = node:get_docstring()
    if node == choiceNode.active_choice then
      row_selection = #buf_text
      row_offset = #text
    end
    vim.list_extend(buf_text, text)
  end

  vim.api.nvim_buf_set_lines(buf, 0, 0, false, buf_text)

  local max_height = 7
  local total_lines = #buf_text
  local height = math.min(total_lines, max_height)

  local width = 0
  for _, line in ipairs(buf_text) do
    width = math.max(width, #line)
  end

  -- Highlight active choice
  local extmark = vim.api.nvim_buf_set_extmark(buf, current_nsid, row_selection, 0, {
    hl_group = 'IncSearch',
    end_line = row_selection + row_offset,
  })

  -- Cursor position to display window below
  local win = vim.api.nvim_open_win(buf, false, {
    relative = 'cursor',
    row = 1,
    col = 0,
    width = width,
    height = height,
    style = 'minimal',
    border = 'rounded',
  })

  -- Scroll to make active choice visible in 7-line window
  if row_selection >= height then
    vim.api.nvim_win_set_cursor(win, { row_selection - math.floor(height / 2) + 1, 0 })
  end

  return { win_id = win, extmark = extmark, buf = buf }
end

function choice_popup(choiceNode)
  -- build stack for nested choiceNodes.
  if current_win then
    vim.api.nvim_win_close(current_win.win_id, true)
    vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
  end
  local create_win = window_for_choiceNode(choiceNode)
  current_win = {
    win_id = create_win.win_id,
    prev = current_win,
    node = choiceNode,
    extmark = create_win.extmark,
    buf = create_win.buf,
  }
end

function update_choice_popup(choiceNode)
  vim.api.nvim_win_close(current_win.win_id, true)
  vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
  local create_win = window_for_choiceNode(choiceNode)
  current_win.win_id = create_win.win_id
  current_win.extmark = create_win.extmark
  current_win.buf = create_win.buf
end

function choice_popup_close()
  vim.api.nvim_win_close(current_win.win_id, true)
  vim.api.nvim_buf_del_extmark(current_win.buf, current_nsid, current_win.extmark)
  -- now we are checking if we still have previous choice we were in after exit nested choice
  current_win = current_win.prev
  if current_win then
    -- reopen window further down in the stack.
    local create_win = window_for_choiceNode(current_win.node)
    current_win.win_id = create_win.win_id
    current_win.extmark = create_win.extmark
    current_win.buf = create_win.buf
  end
end

vim.cmd [[
augroup choice_popup
au!
au User LuasnipChoiceNodeEnter lua choice_popup(require("luasnip").session.event_node)
au User LuasnipChoiceNodeLeave lua choice_popup_close()
au User LuasnipChangeChoice lua update_choice_popup(require("luasnip").session.event_node)
augroup END
]]
