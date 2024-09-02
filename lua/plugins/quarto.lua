return {
    -- Quarto
    {
        "quarto-dev/quarto-nvim",
        dependencies = {
            {
                "jmbuhr/otter.nvim",
                opts = {
                    buffers = {
                        set_filetype = true,
                    },
                    handle_leading_whitespace = true,
                },
            },
        },
        opts = {
            closePreviewOnExit = true,
            lspFeatures = {
                chunks = "all",
                completion = {
                    enabled = true,
                },
            },

            codeRunner = {
                enabled = true,
                default_method = "molten",
                never_run = { "yaml" },
            },
        },
        ft = { "quarto", "markdown" },
    },
    -- Vim-slime
    {
        "jpalardy/vim-slime",
        enabled = true,
        init = function()
            vim.b["quarto_is_python_chunk"] = false
            Quarto_is_in_python_chunk = function()
                require("otter.tools.functions").is_otter_language_context("python")
            end

            vim.cmd([[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
      return [a:text, "\n"]
      else
      return [a:text]
      end
      end
      endfunction
      ]])

            vim.g.slime_target = "neovim"
            vim.g.slime_no_mappings = true
            vim.g.slime_python_ipython = 1
        end,
        config = function()
            vim.keymap.set({ "n", "i" }, "<m-cr>", function()
                vim.cmd([[ call slime#send_cell2() ]])
                end, { desc = "send code cell to terminal" })
        end,
    },
    -- highlight markdown headings and code blocks etc.
    {
        "lukas-reineke/headlines.nvim",
        enabled = true,
        ft = { "quarto", "markdown" },
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("headlines").setup({
                quarto = {
                    query = vim.treesitter.query.parse(
                        "markdown",
                        [[
                (fenced_code_block) @codeblock
                ]]
                    ),
                    codeblock_highlight = "CodeBlock",
                    treesitter_language = "markdown",
                },
                markdown = {
                    query = vim.treesitter.query.parse(
                        "markdown",
                        [[
                (fenced_code_block) @codeblock
                ]]
                    ),
                    codeblock_highlight = "CodeBlock",
                },
            })
        end,
    },
    -- Paste an image from the clipboard or drag-and-drop
    {
        "HakonHarnes/img-clip.nvim",
        event = "BufEnter",
        opts = {
            filetypes = {
                markdown = {
                    url_encode_path = true,
                    template = "![$CURSOR]($FILE_PATH)",
                    drag_and_drop = {
                        download_images = false,
                    },
                },
                quarto = {
                    url_encode_path = true,
                    template = "![$CURSOR]($FILE_PATH)",
                    drag_and_drop = {
                        download_images = false,
                    },
                },
            },
        },
    },
    -- Image
    {
        "3rd/image.nvim",
        event = "VeryLazy",
        enabled = true,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            backend = "kitty",
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = true,
                    filetypes = { "markdown", "quarto" }, -- markdown extensions (ie. quarto) can go here
                },
                neorg = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "norg" },
                },
            },
            tmux_show_only_in_active_window = true,
        },
        config = function(_, opts)
            package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
            package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
            require("image").setup(opts)
        end,
    },
    {
        "mistricky/codesnap.nvim",
        build = "make build_generator",
        cmd = { "CodeSnap", "CodeSnapSave" },
        opts = {
            save_path = "~/Pictures",
            has_breadcrumbs = false,
            bg_theme = "bamboo",
            watermark = "",
            bg_color = "#535c68",
        },
    },
    -- Molten jupyter and things
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- these are examples, not defaults. Please see the readme
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_auto_open_output = true
            vim.g.molten_wrap_output = true
            vim.g.molten_virt_text_output = false
            vim.g.molten_virt_lines_off_by_1 = false
            -- -- Disable MoltenCell. With above config with virtual text is
            -- enough to see wich cells have being run or not.
            vim.cmd.highlight([[clear MoltenCell]])
        end,
    },
}
