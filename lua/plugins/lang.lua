return {
    -- For Python
    {
        'linux-cultist/venv-selector.nvim',
        dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', },
        branch = "regexp",  -- This is the regexp branch, use this for the new version
        opts = {
            anaconda_envs_path = "/Users/yo-lo-pregunto/miniconda3/envs",
            settings = {
                search = {
                    anaconda_envs = {
                        command = 'fd bin/python$ ~/miniconda3/envs --full-path --color never -E /proc', -- change path here to your anaconda envs
                    },
                    anaconda_base = {
                        command = 'fd /python$ ~/miniconda3/bin --full-path --color never -E /proc', -- change path here to your anaconda base
                    },
                },
            },
        },
        ft = { "python", "quarto" },
    },
    -- For C
    {
        'cdelledonne/vim-cmake',
        config = function ()
            -- vim.g["cmake_link_compile_commands"] = 1
            vim.g["cmake_default_config"] = "build-nvim"
        end,
        -- keys = {
        --     { "<leader>cg", "<cmd>CMakeGenerate<CR>", desc = "Generate" },
        --     { "<leader>cq", "<cmd>CMakeClose<CR>", desc = "Close" },
        -- },
        ft = { "c", "cpp" },
    },
    -- Latex
    {
        "lervag/vimtex",
        dependencies = {
            {
                "micangl/cmp-vimtex",
                config = function()
                    require('cmp_vimtex').setup({
                        additional_information = {
                            info_in_menu = true,
                            info_in_window = true,
                            info_max_length = 60,
                            match_against_info = true,
                            symbols_in_menu = true,
                        },
                        bibtex_parser = {
                            enabled = true,
                        },
                        search = {
                            browser = "open",
                            default = "google_scholar",
                            search_engines = {
                                google_scholar = {
                                    name = "Google Scholar",
                                    get_url = require('cmp_vimtex').url_default_format("https://scholar.google.com/scholar?hl=en&q=%s"),
                                },
                                -- Other search engines.
                            },
                        },
                    })
                end,
            },
        },
        init = function ()
            vim.g['tex_conceal'] = 'abdmgs'
            vim.g['vimtex_quickfix_open_on_warning'] = 0
            vim.g['vimtex_view_method'] = 'skim'
            vim.g['vimtex_compiler_latexmk'] = {
                ["out_dir"] = "./tex-build",
                ["aux_dir"] = "./tex-build"
            }
        end
    }
}
