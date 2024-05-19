local actived_venv = function()
  local venv_name = require('venv-selector').get_active_venv()
  if venv_name ~= nil then
    return "  " .. string.match(venv_name, '[^/]*%w$')
  else
    return ''
  end
end

return {
    -- Indentscope
    {
        "echasnovski/mini.indentscope",
        version = "*", -- Stable
        event = "VeryLazy",
        opts = {
            symbol = "▏",
            -- symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "neo-tree",
                    "dashboard",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                    "dashboard",
                    "quarto",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    -- Indent Guides for Neovim
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        opts = {
            indent = {
                char = "▏",
                tab_char = "▏",
            },
            scope = { enabled = false },
            exclude = {
                filetypes = {
                    "help",
                    "Trouble",
                    "neo-tree",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                    "dashboard",
                },
            },
        },
        main = "ibl",
    },
    -- Lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', "benlubas/molten-nvim" },
        opts = {
            options = {
                disabled_filetypes = {
                    statusline = {"NvimTree"},
                },
                ignore_focus = {},
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {'branch', 'diagnostics'},
                lualine_c = { {'filename', path = 1} },
                lualine_x = { 'filetype' },
                lualine_y = { actived_venv, },
                lualine_z = { '%l/%L:%02c' },
            },
            inactive_sections = {
                -- lualine_c = { {'filename', path =1} },
                lualine_x = {'location'},
            },
            extensions = { "neo-tree", "lazy", "toggleterm" },
        },
        config = function (_, opts)
            vim.opt.showmode = false
            require('lualine').setup(opts)
        end
    },
    -- Current word highlighting
    {
        "RRethy/vim-illuminate",
        opts = {
            delay = 100,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
            modes_denylist = {
                "v",
                "vs",
                "V",
                "Vs",
                "<C-V>",
                "<C-V>s",
            }
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
        end,
    },
    -- nicer-looking tabs with close icons
    {
        'nanozuki/tabby.nvim',
        config = function()
            require('tabby.tabline').use_preset 'tab_only'
        end,
    },
}
