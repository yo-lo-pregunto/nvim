local key_local = require('core.utils').set_local
key_local('n', '<localleader>g', '<cmd>CMakeGenerate<cr>', 'CMake Generate')
key_local('n', '<localleader>b', '<cmd>CMakeBuild<cr>', 'CMake Build')
key_local('n', '<localleader>r', '<cmd>CMakeRun<cr>', 'CMake Build')
key_local('n', '<localleader>c', '<cmd>CMakeClean<cr>', 'CMake Clean')
