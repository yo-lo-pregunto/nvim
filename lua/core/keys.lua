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
key.set('n', '<Up>', '<cmd>resize +2<CR>', { silent = true, noremap = true })
key.set('n', '<Down>', '<cmd>resize -2<CR>', { silent = true, noremap = true })
key.set('n', '<Left>', '<cmd>vertical resize -2<CR>', { silent = true, noremap = true })
key.set('n', '<Right>', '<cmd>vertical resize +2<CR>', { silent = true, noremap = true })

-- Clipboard
-- key.set("x", "<leader>p", [["_dP]], { desc = "Replace without overwriting" })
key.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "SysClipboard" })
-- key.set({"n", "v"}, "<leader>d", [["_d]], { desc = "Delete without overwriting" })

-- Exit insert mode
key.set("i", "kj", "<ESC>", { desc = "Exit insert mode" })
key.set("t", "KJ", "<C-\\><C-N>", { desc = "Exit insert mode" })

-- Terminal
key.set("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true })
key.set("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true })
key.set("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true })
key.set("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true })

-- Navigate over quickfix list
key.set('n', '<M-j>', '<cmd>cnext<CR>', { silent = true, noremap = true })
key.set('n', '<M-k>', '<cmd>cprevious<CR>', { silent = true, noremap = true })
