local languages = vim.g.my_languages

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  dependencies = { {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    lazy = false,
    opts = { lookahead = true },
  } },
  opts = {
    install_dir = vim.fn.stdpath 'data' .. '/site',
  },
  config = function()
    local ts = require 'nvim-treesitter'
    ts.install(languages)

    vim.keymap.set('n', '<leader>cI', function()
      local ft = vim.bo.filetype
      local lang = vim.treesitter.language.get_lang(ft)

      vim.notify('Installing Tree-sitter parser for ' .. lang)
      ts.install(lang, { summary = true })
    end, { desc = 'Install TS Parser' })

    -- Text Object Select
    local select = require 'nvim-treesitter-textobjects.select'
    vim.keymap.set({ 'x', 'o' }, 'af', function()
      select.select_textobject('@function.outer', 'textobjects')
    end, { desc = 'Function' })
    vim.keymap.set({ 'x', 'o' }, 'if', function()
      select.select_textobject('@function.inner', 'textobjects')
    end, { desc = 'Function' })
    vim.keymap.set({ 'x', 'o' }, 'ac', function()
      select.select_textobject('@class.outer', 'textobjects')
    end, { desc = 'Class' })
    vim.keymap.set({ 'x', 'o' }, 'ic', function()
      select.select_textobject('@class.inner', 'textobjects')
    end, { desc = 'Class' })
    vim.keymap.set({ 'x', 'o' }, 'ae', function()
      select.select_textobject('@code_cell.outer', 'textobjects')
    end, { desc = 'Code Cell' })
    vim.keymap.set({ 'x', 'o' }, 'ie', function()
      select.select_textobject('@code_cell.inner', 'textobjects')
    end, { desc = 'Code Cell' })

    -- Text Object Swap
    -- keymaps
    local swap = require 'nvim-treesitter-textobjects.swap'
    vim.keymap.set('n', '<leader>tsp', function()
      swap.swap_next '@parameter.inner'
    end, { desc = 'Parameter' })
    vim.keymap.set('n', '<leader>tsP', function()
      swap.swap_previous '@parameter.inner'
    end, { desc = 'Parameter' })
    vim.keymap.set('n', '<leader>tse', function()
      swap.swap_next '@code_cell.outer'
    end, { desc = 'Cell Code' })
    vim.keymap.set('n', '<leader>tsE', function()
      swap.swap_previous '@code_cell.outer'
    end, { desc = 'Cell Code' })

    -- Text Object Move
    local move = require 'nvim-treesitter-textobjects.move'
    local function m_next_start(rhs, query_string, desc)
      vim.keymap.set({ 'n', 'x', 'o' }, rhs, function()
        move.goto_next_start(query_string, 'textobjects')
      end, { desc = desc })
    end
    local function m_next_end(rhs, query_string, desc)
      vim.keymap.set({ 'n', 'x', 'o' }, rhs, function()
        move.goto_next_end(query_string, 'textobjects')
      end, { desc = desc })
    end
    m_next_start(']m', '@function.outer', 'Out Function')
    m_next_start(']]', '@class.outer', 'Out Class')
    m_next_start(']e', '@code_cell.inner', 'Code Block')
    m_next_end(']M', '@function.outer', 'Out Function')
    m_next_end('][', '@class.outer', 'Out Class')

    local function m_prev_start(rhs, query_string, desc)
      vim.keymap.set({ 'n', 'x', 'o' }, rhs, function()
        move.goto_previous_start(query_string, 'textobjects')
      end, { desc = desc })
    end
    local function m_prev_end(rhs, query_string, desc)
      vim.keymap.set({ 'n', 'x', 'o' }, rhs, function()
        move.goto_previous_end(query_string, 'textobjects')
      end, { desc = desc })
    end

    m_prev_start('[m', '@function.outer', 'Out Function')
    m_prev_start('[]', '@class.outer', 'Out Class')
    m_prev_start('[e', '@code_cell.inner', 'Code Block')
    m_prev_end('[M', '@function.outer', 'Out Function')
    m_prev_end('[[', '@class.outer', 'Out Class')
  end,
}
