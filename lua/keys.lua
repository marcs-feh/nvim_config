--- Keybindings ---
local def_key_opts = { noremap = true, silent = true }
local function keymap(mode, seq, cmd, options)
	if not options then
		options = def_key_opts
	end
 vim.api.nvim_set_keymap(mode, seq, cmd, options)
end

-- Remap space as leader key
keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Q is basically useless
keymap("", "Q", "<Nop>")

-- Save
keymap("n", "<C-s>", ":w<CR>")

-- -- Open file to edit
-- keymap("n", "<leader>e", ":Telescope find_files<CR>")
--
-- -- Open buffers
-- keymap("n", "<leader>b", ":Telescope buffers<CR>")
--
-- Clear search highlight
keymap("n", "<leader>l", ":noh<CR>")

-- Clear trailing whitespace
keymap("n", "<leader>W", ":%s/\\s\\+$//<CR>:noh<CR>")

-- Select all
keymap("n", "<C-a>", ":normal ggVG<CR>")

-- Better page up/down
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-d>", "<C-d>zz")

-- Split windows
keymap("n", "<leader>sh", ":split<CR>")
keymap("n", "<leader>sv", ":vsplit<CR>")

-- Expand window
keymap("n", "<leader>F", ":resize<CR>:vertical resize<CR>")

-- Better window navigation
keymap("n", "<A-h>", "<C-w>h")
keymap("n", "<A-j>", "<C-w>j")
keymap("n", "<A-k>", "<C-w>k")
keymap("n", "<A-l>", "<C-w>l")
keymap("n", "<leader>q", ":close<CR>")
keymap("n", "<leader>x", ":bdelete<CR>")
keymap("n", "<leader>X", ":bdelete!<CR>")

-- Resize windows
keymap("n", "<A-K>", ":resize +2<CR>")
keymap("n", "<A-J>", ":resize -2<CR>")
keymap("n", "<A-H>", ":vertical resize -2<CR>")
keymap("n", "<A-L>", ":vertical resize +2<CR>")

-- Re organize windows
keymap("n", "<leader>H", "<C-w>H")
keymap("n", "<leader>J", "<C-w>J")
keymap("n", "<leader>K", "<C-w>K")
keymap("n", "<leader>L", "<C-w>L")

-- Navigate buffers
keymap("n", "L", ":bnext<CR>")
keymap("n", "H", ":bprevious<CR>")

-- New buffer
keymap("n", "<leader>n", ":enew<CR>")

-- Mini.completion
keymap("i", "<Tab>",   [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true } )
keymap("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Quick Align
keymap("v", "<leader>a", ':lua QuickAlign(0, nil)<CR>')

-- Move text
keymap("x", "<C-j>", ":move '>+1<cr>gv-gv")
keymap("x", "<C-k>", ":move '<-2<cr>gv-gv")

-- Open terminal
keymap("n", "<leader>T",
	  ":split | :resize 6 | :terminal<CR>"
	..":setlocal nonumber wrap signcolumn=no<CR>")

-- Better terminal navigation
keymap("t", "<A-h>", "<C-\\><C-N><C-w>h")
keymap("t", "<A-j>", "<C-\\><C-N><C-w>j")
keymap("t", "<A-k>", "<C-\\><C-N><C-w>k")
keymap("t", "<A-l>", "<C-\\><C-N><C-w>l")
keymap("t", "<A-ESC>", "<C-\\><C-N>")
keymap("t", "<C-A-d>", "<C-\\><C-N>:bdelete!<CR>")

-- Resize in terminal mode
keymap("t", "<A-K>", "<C-\\><C-N>:resize +2<CR>a")
keymap("t", "<A-J>", "<C-\\><C-N>:resize -2<CR>a")
keymap("t", "<A-H>", "<C-\\><C-N>:vertical resize -2<CR>a")
keymap("t", "<A-L>", "<C-\\><C-N>:vertical resize +2<CR>a")

