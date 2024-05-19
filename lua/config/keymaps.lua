local key = vim.keymap

-- Move current line up(K) or down(J)
key.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
key.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Navigation
key.set("n", "H", "<cmd>tabprevious<cr>", { desc = "Prev Tab" })
key.set("n", "L", "<cmd>tabnext<cr>", { desc = "Next Tab" })

-- Place cursor always at the middle
key.set("n", "<C-d>", "<C-d>zz")
key.set("n", "<C-u>", "<C-u>zz")
key.set("n", "n", "nzzzv")
key.set("n", "N", "Nzzzv")

-- Resize window using <shift> arrow keys
key.set('n', '<S-Up>', '<cmd>resize +2<CR>', { silent = true, noremap = true })
key.set('n', '<S-Down>', '<cmd>resize -2<CR>', { silent = true, noremap = true })
key.set('n', '<S-Left>', '<cmd>vertical resize -2<CR>', { silent = true, noremap = true })
key.set('n', '<S-Right>', '<cmd>vertical resize +2<CR>', { silent = true, noremap = true })

-- Save and quit
key.set("n", "<leader>w", "<cmd>w!<cr>", { desc = "Save" })
key.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Clipboard
key.set("x", "<leader>p", [["_dP]], { desc = "Replace without overwriting" })
key.set({"n", "v"}, "<leader>y", [["+y]], { desc = "SysClipboard" })
key.set({"n", "v"}, "<leader>d", [["_d]], { desc = "Delete without overwriting" })

-- Exit insert mode
key.set("i", "kj", "<ESC>", { desc = "Exit insert mode" })
key.set("t", "KJ", "<C-\\><C-N>", { desc = "Exit insert mode" })

-- Terminal --
key.set("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true })
key.set("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true })
key.set("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true })
key.set("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true })

local function new_terminal(lang)
    vim.cmd('vsplit term://' .. lang)
end

local function new_terminal_python()
    new_terminal 'python'
end

local function new_terminal_ipython()
    new_terminal 'ipython'
end

local function new_terminal_shell()
    new_terminal '$SHELL'
end

key.set('n', '<leader>op', new_terminal_python, { silent = true, noremap = true, desc = 'Python', })
key.set('n', '<leader>oi', new_terminal_ipython, { silent = true, noremap = true, desc = 'IPython', })
key.set('n', '<leader>os', new_terminal_shell, { silent = true, noremap = true, desc= 'Shell', })
