-- Disable lazyvim keymaps
vim.keymap.del("n", "<S-l>")
vim.keymap.del("n", "<S-h>")
vim.keymap.del({ "n", "i", "v" }, "<A-j>")
vim.keymap.del({ "n", "i", "v" }, "<A-k>")
vim.keymap.del({ "n", "i", "v" }, "<C-s>")

-- Set variables for keymaps
local opts = { noremap = true, silent = true }
local nopts = { noremap = true, silent = false }
local map = vim.api.nvim_set_keymap
local setmap = vim.keymap.set
local jump_opt = { noremap = false, silent = true }

-- Select all
map("n", "<leader>A", "GVgg", opts)

-- Window, Buffer, Tab Navigation
map("n", "<C-x>", "<CMD>close<CR>", opts) -- Close Pane
map("n", "<C-s>", "<CMD>silent w<CR>", opts) -- Save File
map("n", "<C-q>", "<CMD>qa<CR>", opts) -- Close Neovim

-- TODO: Disable todo comments
map("n", "[t", "<CMD>tabprevious<CR>", opts)
map("n", "]t", "<CMD>tabnext<CR>", opts)

-- Close all buffers except current
map("n", "<leader>oa", ":%bd! | e# |bd#<CR>", opts)

-- Manual search and replace in buffer
map("n", "<leader>rn", "*Ncgn", opts)
map("n", "<leader>rm", 'yiw:%s/<C-r>"/', nopts)

-- Backspace
map("i", "<M-BS>", "<C-W>", opts)

-- Move
map("n", "<M-Down>", "<CMD>m .+1<CR>==", { desc = "Move down" })
map("n", "<M-Up>", "<CMD>m .-2<CR>==", { desc = "Move up" })
map("i", "<M-Down>", "<esc><CMD>m .+1<CR>==gi", { desc = "Move down" })
map("i", "<M-Up>", "<esc><CMD>m .-2<CR>==gi", { desc = "Move up" })
map("v", "<M-Down>", "<CMD>m '>+1<CR>gv=gv", { desc = "Move down" })
map("v", "<M-Up>", "<CMD>m '<-2<CR>gv=gv", { desc = "Move up" })

-- CMD+/ to comment
map("v", "<D-/>", "<CMD>normal gcc<CR>", opts)
map("n", "<D-/>", "<CMD>normal gcc<CR>", opts)

-- Improved yank
map("n", "<leader>y", "^vg_y", opts)
