local build_str = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"

return {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        { "nvim-telescope/telescope-fzf-native.nvim", build = build_str },
        "nvim-telescope/telescope-bibtex.nvim",
    },
    config = function(_, _) -- params: plugin, opts
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                layout_strategy = "horizontal",
                layout_config =  { preview_width = 0.6 },
                mappings = {
                    i = {
                        ["<ESC>"] = actions.close,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<RightMouse>"] = actions.close,
                        ["<LeftMouse>"] = actions.select_default,
                        ["<ScrollWheelDown>"] = actions.move_selection_next,
                        ["<ScrollWheelUp>"] = actions.move_selection_previous,
                    }
                },
            },
            pickers = {
                live_grep = {
                    theme = "ivy",
                },
                current_buffer_fuzzy_find = {
                    theme = 'ivy',
                },
                grep_string = {
                    theme = 'ivy',
                }
            },
            extensions = {
                bibtex = {
                    depth = 1,
                    -- Depth for the *.bib file
                    global_files = {'~/Library/texmf/bibtex/bib/Transformers.bib'},
                    -- Path to global bibliographies (placed outside of the project)
                    search_keys = { 'author', 'year', 'title' },
                    -- Define the search keys to use in the picker
                    citation_format = '{{author}} ({{year}}), {{title}}.',
                    -- Template for the formatted citation
                    citation_trim_firstname = true,
                    -- Only use initials for the authors first name
                    citation_max_auth = 2,
                    -- Max number of authors to write in the formatted citation
                    -- following authors will be replaced by "et al."
                    custom_formats = {
                        {id = 'citet', cite_maker = '\\citet{%s}'}
                    },
                    -- Custom format for citation label
                    format = 'citet',
                    -- Format to use for citation label.
                    -- Try to match the filetype by default, or use 'plain'
                    context = true,
                    -- Context awareness disabled by default
                    context_fallback = true,
                    -- Fallback to global/directory .bib files if context not found
                    -- This setting has no effect if context = false
                    wrap = false,
                    -- Wrappin
                },
            }
        })

        telescope.load_extension("fzf")
        telescope.load_extension("bibtex")
    end,
    cmd = "Telescope",
    keys = function()
        local builtin = require("telescope.builtin")
        local ivy = require('telescope.themes').get_ivy()

        local function telescope_live_grep_open_files()
            require('telescope.builtin').live_grep({
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            })
        end

        return {
            { "<leader>so", function() telescope_live_grep_open_files() end, desc = 'Open Files' },
            { "<leader>sf", function() builtin.find_files(ivy) end, desc = "File", },
            { "<leader>sh", function() builtin.help_tags(ivy) end, desc = "Help", },
            { "<leader>sr", function() builtin.resume(ivy) end, desc = "Resume", },
            { "<leader>sw", function() builtin.grep_string(ivy) end, desc = "word" },
            { "<leader>sj", function() builtin.jumplist(ivy) end, desc= "Jumps" },
            { "<leader>sc", function() builtin.colorscheme(ivy) end, desc = "Colorscheme" },
            { "<leader>s/", function() builtin.current_buffer_fuzzy_find() end, desc = "Buffer" },
            { "<leader>sg", function()
                builtin.grep_string({ search = vim.fn.input("Grep > "),  })
            end, desc = "Grep" }
        }
    end,
}
