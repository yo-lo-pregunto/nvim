-- [[ Configure LSP ]]
-- This function gets run when an LSP connects to a particular buffer.

local function hover()
    if vim.bo.filetype == 'tex' then
        vim.cmd.VimtexDocPackage()
    else
        vim.lsp.buf.hover()
    end
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
        local telescope = require 'telescope.builtin'

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        assert(client, 'LSP client not found')

        ---@diagnostic disable-next-line: inject-field
        client.server_capabilities.document_formatting = true
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local nmap = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
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
        nmap('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message' )
        nmap(']d', vim.diagnostic.goto_next, 'Go to next diagnostic message' )

        -- See `:help K` for why this keymap
        nmap('K', hover, 'Hover Documentation')
        nmap('<C-s>', vim.lsp.buf.signature_help, 'Signature Documentation')
        nmap('<leader>ld', vim.diagnostic.open_float, 'Show line diagnostic')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, 'Declaration')

        -- Create a command `:Format` local to the LSP buffer
        -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        --     vim.lsp.buf.format()
        -- end, { desc = 'Format current buffer with LSP' })
    end
})

local border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"⎪", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"⎪", "FloatBorder"},
}

-- LSP settings (for overriding per client)
local handlers =  {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        { 'j-hui/fidget.nvim', opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
    },
    config = function()
        local mason_lspconfig = require('mason-lspconfig')
        local servers = require('servers')

        require("neodev").setup()

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        mason_lspconfig.setup_handlers {
            function(server_name)
                if server_name == 'pyright' then
                    capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
                end
                servers[server_name].capabilities = capabilities
                servers[server_name].handlers = handlers
                require('lspconfig')[server_name].setup(servers[server_name])
            end,
        }
    end,
}
