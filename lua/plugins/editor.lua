return {
    -- Tmux & split window navigation
    {
        'christoomey/vim-tmux-navigator',
        config = function ()
            vim.keymap.set('t', '<C-h>', '<C-\\><C-N>:TmuxNavigateLeft<CR>', { silent = true })
            vim.keymap.set('t', '<C-j>', '<C-\\><C-N>:TmuxNavigateDown<CR>', { silent = true })
            vim.keymap.set('t', '<C-k>', '<C-\\><C-N>:TmuxNavigateUp<CR>', { silent = true })
            vim.keymap.set('t', '<C-l>', '<C-\\><C-N>:TmuxNavigateRight<CR>', { silent = true })
        end
    },
    -- Neo-tree
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
            -- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        opts = {
            source_selector = {
                winbar = true,
            },
            filesystem = {
                hijack_netrw_behavior = 'open_current',
            },
            window = {
                mappings = {
                    ['<space>'] = 'none',
                    ['h'] = 'prev_source',
                    ['l'] = 'next_source',
                    ['o'] = 'toggle_node',
                    ['oc'] = 'none',
                    ['od'] = 'none',
                    ['og'] = 'none',
                    ['om'] = 'none',
                    ['on'] = 'none',
                    ['os'] = 'none',
                    ['ot'] = 'none',
                }
            },
            event_handlers = {
                {
                    event = 'file_opened',
                    handler = function(_)
                        require("neo-tree.command").execute({ action = 'close' })
                    end
                },
            }
        },
        config = function(_, opts)
            require('neo-tree').setup(opts)
            vim.keymap.set('n', '<leader>e',
                function()
                    require('neo-tree.command').execute({ toggle = true })
                end,
                { desc = 'Explorer' })
        end,
    },
    -- Which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
        },
        config = function(_, opts)
            vim.opt.timeout = true
            vim.opt.timeoutlen = 300
            local wk = require("which-key")
            wk.setup(opts)
            wk.add({
                { "<leader>g", group="Git" },
                { "<leader>l", group = "Lsp" },
                { "<leader>s", group = "Search" },
                { "<leader>h", group = "Harpoon" },
                { "<leader>n", group = "Node" },
                { "<leader>o", group = "Open" },
                { "<leader>b", group = "Buffer" },
                { "<leader>;", group = "Local Maps" },
            })
        end,
    },
    -- Harpoon
    {
        'ThePrimeagen/harpoon',
        keys = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")
            return {
                { "<leader>ha", mark.add_file, desc = "Add" },
                { "<leader>he", ui.toggle_quick_menu, desc = "View" },
                { "<leader>hj", function() ui.nav_file(1) end, desc = "Buf 1" },
                { "<leader>hk", function() ui.nav_file(2) end, desc = "Buf 2" },
                { "<leader>hl", function() ui.nav_file(3) end, desc = "Buf 3" },
                { "<leader>h;", function() ui.nav_file(3) end, desc = "Buf 4" },
            }
        end,
    },
    -- Toggleterm
    {
        "akinsho/toggleterm.nvim",
        versin = "*",
        opts = {
            --        shading_factor = -1
        },
        keys = {
            { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Terminal" },
        },
        cmd = "ToggleTerm",
    },
        -- Comments
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            enable_autocmd = false,
        },
    },
    {
        "echasnovski/mini.comment",
        event = "InsertEnter",
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
                end,
            },
        },
    },
    -- Gx
    {
        'chrishrb/gx.nvim',
        keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
        cmd = { 'Browse' },
        init = function()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
    },
    -- disables hungry features for files larget than 2MB
    { 'LunarVim/bigfile.nvim' },

    -- BufferDelete
    {
        'echasnovski/mini.bufremove',
        version = '*',
        opts = {},
        keys = {
            { '<leader>bd', '<cmd>:lua MiniBufremove.delete()<cr>', desc = 'Delete' },
            { '<leader>bw', '<cmd>:lua MiniBufremove.wipeout()<cr>', desc = 'Wipeout' },
            { '<leader>bs', '<cmd>:lua MiniBufremove.unshow()<cr>', desc = 'Unshow' },
        }
    },
    {
        'Bekaboo/dropbar.nvim',
        -- optional, but required for fuzzy finder support
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim'
        },
        opts = {},
    }
}
