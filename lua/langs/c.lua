return {
  plugins = {
    {
      'Civitasv/cmake-tools.nvim',
      dependencies = 'akinsho/toggleterm.nvim',
      opts = {
        cmake_executor = { name = 'quickfix' },
        cmake_runner = { name = 'toggleterm' },
      },
      ft = { 'c', 'cpp', 'cmake' },
    },
  },
  server = { 'clangd' },
  format = { 'clang-format' },
  opts = {},
}
