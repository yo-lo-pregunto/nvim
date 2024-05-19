return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require('mason')
        local mason_lspconfig = require('mason-lspconfig')
        local servers = require('servers')
        mason.setup()
        mason_lspconfig.setup({
            ensure_installed = vim.tbl_keys(servers)
        })

        vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            underline = true,
            float = {
                focusable = false,
                style = 'minimal',
                border = 'rounded',
                source = 'always',
                header = '',
                prefix = '',
            },
        })
    end,
}
