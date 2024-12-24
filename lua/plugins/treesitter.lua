return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { "VeryLazy", "BufReadPre" },
        opts = {
            auto_install = true,
            ensure_installed = {
                'python',
                'c',
                'markdown',
                'markdown_inline',
                'bash',
                'yaml',
                'lua',
                'vim',
                'query',
                'vimdoc',
            },
            highlight = {
                enable = true,
                disable = { 'latex', },
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = 'gn',
                    node_incremental = ']]',
                    scope_incremental = false,
                    node_decremental = '[[',
                },
            },
        },
        config = function(_, opts)
            require 'nvim-treesitter.configs'.setup(opts)
        end
    }
}
