--- General Options ---
local set = require 'mf.utils'.set_opt

set {
	-- Creates a backup file
	backup = false,
	-- Required to keep multiple buffers open
	hidden = true,
	-- Allows neovim to access the system clipboard
	clipboard = "unnamedplus",
	-- Command line height
	cmdheight = 1,
	-- Mostly just for cmp
	completeopt = { "menuone", "noselect" },
	-- So that `` is visible in markdown files
	conceallevel = 0,
	-- The encoding written to a file
	fileencoding = "utf-8",
	-- Highlight all matches on previous search pattern
	hlsearch = false,
	-- Ignore case in search patterns
	ignorecase = true,
	-- Allow the mouse to be used in neovim
	mouse = "a",
	-- Pop up menu height
	pumheight = 10,
	-- Don't show things like -- INSERT -- anymore
	showmode = false,
	-- Always show tabs
	showtabline = 2,
	-- Smart case
	smartcase = true,
	-- Force all horizontal splits to go below current window
	splitbelow = true,
	-- Force all vertical splits to go to the right of current window
	splitright = true,
	-- Creates a swapfile
	swapfile = false,
	-- Time to wait for a mapped sequence to complete (in milliseconds)
	timeoutlen = 1000,
	-- Enable persistent undo
	undofile = true,
	-- Faster completion
	updatetime = 300,
	-- Make indenting smarter
	smartindent = true,
	-- If a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
	writebackup = false,
	-- Use real tabs for indenting. This is objectively superior and helps with accessibility.
	expandtab = false,
	-- Required for colorschemes to work
	termguicolors = true,
	-- Insert 2 spaces for a tab
	tabstop = 2,
	-- The number of spaces inserted for each indentation
	shiftwidth = 2,
	-- Highlight the current line
	cursorline = true,
	-- Numbered lines
	number = true,
	-- Relative numbered lines
	relativenumber = false,
	-- Number column width
	numberwidth = 2,
	-- Always show the sign column
	signcolumn = "yes",
	-- Display lines as one long line
	wrap = false,
	-- Required for Treesitter folding
	foldmethod = 'expr',
	-- Treesitter based folding
	foldexpr = 'nvim_treesitter#foldexpr()',
	-- Don't auto fold
	foldlevelstart = 99,
	-- start scrolling n spaces early before hitting an editor wall.
	scrolloff = 8,
	sidescrolloff = 12,
}

vim.opt.shortmess:append "c"

-- Stop making line comments when pressing o, this abomination is required
-- because Vim's ftplugins are fucking retarded.
vim.cmd [[autocmd FileType * set formatoptions-=o]]

