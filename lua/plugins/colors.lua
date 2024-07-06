return {
    {
        'marko-cerovac/material.nvim',
        enable = true,
        priority = 1000,
        lazy = false,
        opts = {
            custom_highlights = {
                Visual = { bg = '#BB00BB' },
            },
            disable = {
                background = false,
            },
        },
    },
    -- color html
    {
        'NvChad/nvim-colorizer.lua',
        enabled = true,
        opts = {},
    },
    { "catppuccin/nvim", name = "catppuccin",},
    {
        "tiagovla/tokyodark.nvim",
        opts = {
            -- custom options here
        },
        -- config = function(_, opts)
        --     require("tokyodark").setup(opts) -- calling setup is optional
        --     vim.cmd [[colorscheme tokyodark]]
        -- end,
    },
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        -- config = function()
        --     -- Optionally configure and load the colorscheme
        --     -- directly inside the plugin declaration.
        --     vim.g.gruvbox_material_enable_italic = true
        --     vim.g.gruvbox_material_background = 'hard'
        --     vim.cmd.colorscheme('gruvbox-material')
        -- end
    },
    { "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('duskfox')
        end
    }
}
