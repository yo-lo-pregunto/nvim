local langs = require 'langs'

local function hover()
  if vim.bo.filetype == 'text' then
    vim.cmd.VimtexDocPackage()
  else
    vim.lsp.buf.hover()
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    --        local telescope = require 'telescope.builtin'

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    assert(client, 'LSP client not found')

    ---@diagnostic disable-next-line: inject-field
    client.server_capabilities.document_formatting = true
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    local imap = function(keys, func, desc)
      vim.keymap.set('i', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    nmap('<leader>lr', vim.lsp.buf.rename, 'Rename')
    nmap('<leader>la', vim.lsp.buf.code_action, 'Action')

    nmap('gd', require('telescope.builtin').lsp_definitions, 'Definition')
    nmap('gr', require('telescope.builtin').lsp_references, 'References')
    nmap('gI', require('telescope.builtin').lsp_implementations, 'Implementation')
    nmap('<leader>lD', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
    nmap('<leader>ls', require('telescope.builtin').lsp_document_symbols, 'Symbols')
    nmap('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

    -- Diagnostic keymaps
    nmap('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
    nmap(']d', vim.diagnostic.goto_next, 'Go to next diagnostic message')

    -- See `:help K` for why this keymap
    nmap('K', hover, 'Hover Documentation')
    nmap('<leader>ld', vim.diagnostic.open_float, 'Show line diagnostic')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, 'Declaration')

    imap('<C-s>', vim.lsp.buf.signature_help, 'Signature Documentation')

    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = event.buf,
      callback = function()
        vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
      end,
    })
  end
})


local M = {
  { 'j-hui/fidget.nvim', opts = {} },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
        underline = true,
        float = {
          focusable = false,
          style = 'minimal',
          border = 'rounded',
          source = true,
          header = '',
          prefix = '',
        },
      })

      require 'mason'.setup()
      require 'mason-lspconfig'.setup()
      require 'mason-lspconfig'.setup_handlers {
        function(server_name)
          local ln = langs.servers[server_name] or {}
          local opts = langs[ln].opts or {}
          opts.capabilities = require('blink.cmp').get_lsp_capabilities(opts.capabilities or {})
          require 'lspconfig'[server_name].setup(opts)
        end
      }
    end,
  }
}

for _, t in pairs(langs) do
  table.insert(M, t.plugins or nil)
end

return M
