--- Keybindings ---

local map = require 'utils'.keymap

-- Remap space as leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- Q is basically useless
map("", "Q", "<Nop>")

-- Save
map("n", "<C-s>", ":w<CR>")

-- -- Open file to edit
-- map("n", "<leader>e", ":Telescope find_files<CR>")
--
-- -- Open buffers
-- map("n", "<leader>b", ":Telescope buffers<CR>")
--
-- Clear search highlight
map("n", "<leader>l", ":noh<CR>")

-- Clear trailing whitespace
map("n", "<leader>W", ":%s/\\s\\+$//<CR>:noh<CR>")

-- Select all
map("n", "<C-a>", ":normal ggVG<CR>")

-- Better page up/down
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- Split windows
map("n", "<leader>sh", ":split<CR>")
map("n", "<leader>sv", ":vsplit<CR>")

-- Expand window
map("n", "<leader>F", ":resize<CR>:vertical resize<CR>")

-- Better window navigation
map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")
map("n", "<leader>q", ":close<CR>")
map("n", "<leader>x", ":bdelete<CR>")
map("n", "<leader>X", ":bdelete!<CR>")

-- Resize windows
map("n", "<A-K>", ":resize +2<CR>")
map("n", "<A-J>", ":resize -2<CR>")
map("n", "<A-H>", ":vertical resize -2<CR>")
map("n", "<A-L>", ":vertical resize +2<CR>")

-- Re organize windows
map("n", "<leader>H", "<C-w>H")
map("n", "<leader>J", "<C-w>J")
map("n", "<leader>K", "<C-w>K")
map("n", "<leader>L", "<C-w>L")

-- Navigate buffers
map("n", "L", ":bnext<CR>")
map("n", "H", ":bprevious<CR>")

-- New buffer
map("n", "<leader>n", ":enew<CR>")

-- Mini.completion
map("i", "<Tab>",   [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true } )
map("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move text
map("x", "<C-j>", ":move '>+1<cr>gv-gv")
map("x", "<C-k>", ":move '<-2<cr>gv-gv")

-- Open terminal
map("n", "<leader>T",
	  ":split | :resize 6 | :terminal<CR>"
	..":setlocal nonumber wrap signcolumn=no<CR>")

-- Better terminal navigation
map("t", "<A-h>", "<C-\\><C-N><C-w>h")
map("t", "<A-j>", "<C-\\><C-N><C-w>j")
map("t", "<A-k>", "<C-\\><C-N><C-w>k")
map("t", "<A-l>", "<C-\\><C-N><C-w>l")
map("t", "<A-ESC>", "<C-\\><C-N>")
map("t", "<C-A-d>", "<C-\\><C-N>:bdelete!<CR>")

-- Resize in terminal mode
map("t", "<A-K>", "<C-\\><C-N>:resize +2<CR>a")
map("t", "<A-J>", "<C-\\><C-N>:resize -2<CR>a")
map("t", "<A-H>", "<C-\\><C-N>:vertical resize -2<CR>a")
map("t", "<A-L>", "<C-\\><C-N>:vertical resize +2<CR>a")

