return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
    },
    build = ':TSUpdate',
    opts = {
        auto_install = true,
        ensure_installed = {
            'python',
            'python',
            'markdown',
            'markdown_inline',
            'bash',
            'yaml',
            'lua',
            'vim',
            'query',
            'vimdoc',
            'latex',
            'html',
            'css',
            'dot',
            'norg',
            'typescript',
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
                init_selection = '<leader>ns',
                node_incremental = '<leader>ni',
                scope_incremental = '<leader>ns',
                node_decremental = '<leader>nd',
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ['aa'] = '@parameter.outer',
                    ['ia'] = '@parameter.inner',
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                    ["]b"] = { query = "@code_cell.inner", desc = "next code block" },
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                    ["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
            swap = {
                enable = false,
                swap_next = {
                    ['<leader>a'] = '@parameter.inner',
                },
                swap_previous = {
                    ['<leader>A'] = '@parameter.inner',
                },
            },
        }
    },
    config = function (_, opts)
        vim.cmd[[
        set foldmethod=expr
        set foldexpr=nvim_treesitter#foldexpr()
        set nofoldenable                     " Disable folding at startup.
        ]]
        require("nvim-treesitter.configs").setup(opts)
    end,
}
