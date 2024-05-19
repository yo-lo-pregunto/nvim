return {
    -- Neorg
    {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- We'd like this plugin to load first out of the rest
        config = true, -- This automatically runs `require("luarocks-nvim").setup()`
    },
    {
        "nvim-neorg/neorg",
        dependencies = { "luarocks.nvim" },
        version = "*",
        cmd = "Neorg",
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.concealer"] = {
                        config = {
                            folds = true,
                            icons_preset = "diamond",
                        },
                    }, -- Adds pretty icons to your documents
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                notes = "~/Neorg/notes",
                            },
                            default_workspace = "notes",
                        },
                        ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
                        ["core.integrations.nvim-cmp"] = {},
                    },
                    ["core.summary"] = {},
                    ["core.journal"] = {
                        config = {
                            journal_folder = "../journal",
                            strategy = "flat",
                        }

                    },
                    ["core.esupports.metagen"] = {},
                    ["core.export"] = {},
                    ["core.export.markdown"] = {
                        config = {
                            extensions = "all",
                        },
                    },
                },
            }
        end,
    }
}
