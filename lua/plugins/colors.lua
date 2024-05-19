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
    }
}
