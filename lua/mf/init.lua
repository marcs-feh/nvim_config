--- auto_cmd.lua ---
do
--- Auto commands ---
local U   = require 'mf.utils'
local api = vim.api
local g   = vim.g
local b   = vim.b
local set = U.set_local
local map = U.keymap

-- Indent sensitive languages and/or languages that look weird with hard tabs
api.nvim_create_autocmd('FileType', {
	pattern  = 'markdown,ninja,scheme,org,python,nim,lisp,sml,clojure,vim',
	callback = function()
		set {
			expandtab = true,
		}
	end
})

-- Odin
api.nvim_create_autocmd('FileType', {
	pattern  = 'odin',
	callback = function()
		local opts = {noremap = true, silent = true, buffer = 0}
		map('n', '<C-c><C-c>', function() U.compile('odin run .') end, opts)
		map('n', '<C-c><C-t>', function() U.compile('odin test .') end, opts)
		set {
			expandtab = false,
			commentstring = '// %s',
		}
		b.minipairs_disable = true
	end
})

-- Shell languages
api.nvim_create_autocmd('FileType', {
	pattern = 'bash,zsh,sh,fish,ps1',
	callback = function()
		b.minipairs_disable = true
	end
})

-- LISPs
api.nvim_create_autocmd('FileType', {
	pattern = 'scheme,clojure,lisp',
	callback = function()
		MiniPairs.unmap('i', "'", "''")
	end
})

-- SQL
api.nvim_create_autocmd('FileType', {
	pattern  = 'sql',
	callback = function()
		set {
			expandtab = true,
			commentstring = '--%s',
		}
	end
})

-- XML, HTML
api.nvim_create_autocmd('FileType', {
	pattern = 'xml,html',
	callback = function()
		set {
			expandtab  = true,
			shiftwidth = 1,
			tabstop    = 1,
		}
	end,
})

-- Python
api.nvim_create_autocmd('FileType', {
	pattern  = 'python',
	callback = function()
		g.python_recommended_style = 0
		set {
			expandtab  = true,
			tabstop    = 2,
			shiftwidth = 2,
		}
	end,
})

-- C/C++
api.nvim_create_autocmd('FileType', {
	pattern  = 'c,cpp',
	callback = function()
		set {
			commentstring = '// %s',
			foldmethod = 'indent',
		}
		b.minipairs_disable = true
		local opts = {noremap = true, silent = true, buffer = 0}
		map('n', '<leader>hg', function() U.include_guard(0) end , opts)
		map('i', '<C-f>', '->', opts)

		-- cmd [[TSDisable indent]] -- Treesitter indentation doesnt play very well with macros
	end
})

-- Rust, I *really* hate how rust projects insist on objectively bad indentation for accessibility
api.nvim_create_autocmd('FileType', {
	pattern = 'rust',
	callback = function()
		set {
			expandtab  = false,
			shiftwidth = 2,
			tabstop    = 2,
		}
	end,
})

-- Zig, another language that shoves bad indentation down everyone's throat.
api.nvim_create_autocmd('FileType', {
	pattern = 'zig',
	callback = function()
		local opts = {noremap = true, silent = true, buffer = 0}
		g.zig_fmt_autosave = 0
		map('n', '<C-c><C-c>', function() U.compile('zig build run') end, opts)
		map('n', '<C-c><C-t>', function() U.compile('zig build test') end, opts)
		set {
			commentstring = '// %s',
			expandtab     = true,
			tabstop       = 4,
			shiftwidth    = 4,
		}
	end
})

end
--- cmp.lua ---
do
local cmp = require 'cmp'

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
		vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
		       :sub(col, col)
		       :match('%s') == nil
end

cmp.setup {
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<Tab>'] = function(fallback)
			if not cmp.select_next_item() then
				if vim.bo.buftype ~= 'prompt' and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		end,
		['<CR>'] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources(
		{
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
		},
		{
			{ name = 'buffer' },
	 })
}
end
--- init.lua ---
do
local M = {}

M.setup = function ()
	require 'mf.options'
	require 'mf.keys'
	require 'mf.plugins'
	require 'mf.auto_cmd'
	require 'mf.nvim_theme'
	require 'mf.mini_nvim'
	require 'mf.lsp'
	require 'mf.luasnip'
	require 'mf.cmp'
	require 'mf.treesitter'
	require 'mf.nvim_tree'
	require 'mf.telescope'
	require 'mf.no_neck_pain'
	-- Useful for debugging
	P = function (t) print(vim.inspect(t)) end
end

return M
end
--- init.new.lua ---
do
--- auto_cmd.lua ---
do
--- Auto commands ---
local U   = require 'mf.utils'
local api = vim.api
local g   = vim.g
local b   = vim.b
local set = U.set_local
local map = U.keymap

-- Indent sensitive languages and/or languages that look weird with hard tabs
api.nvim_create_autocmd('FileType', {
	pattern  = 'markdown,ninja,scheme,org,python,nim,lisp,sml,clojure,vim',
	callback = function()
		set {
			expandtab = true,
		}
	end
})

-- Odin
api.nvim_create_autocmd('FileType', {
	pattern  = 'odin',
	callback = function()
		local opts = {noremap = true, silent = true, buffer = 0}
		map('n', '<C-c><C-c>', function() U.compile('odin run .') end, opts)
		map('n', '<C-c><C-t>', function() U.compile('odin test .') end, opts)
		set {
			expandtab = false,
			commentstring = '// %s',
		}
		b.minipairs_disable = true
	end
})

-- Shell languages
api.nvim_create_autocmd('FileType', {
	pattern = 'bash,zsh,sh,fish,ps1',
	callback = function()
		b.minipairs_disable = true
	end
})

-- LISPs
api.nvim_create_autocmd('FileType', {
	pattern = 'scheme,clojure,lisp',
	callback = function()
		MiniPairs.unmap('i', "'", "''")
	end
})

-- SQL
api.nvim_create_autocmd('FileType', {
	pattern  = 'sql',
	callback = function()
		set {
			expandtab = true,
			commentstring = '--%s',
		}
	end
})

-- XML, HTML
api.nvim_create_autocmd('FileType', {
	pattern = 'xml,html',
	callback = function()
		set {
			expandtab  = true,
			shiftwidth = 1,
			tabstop    = 1,
		}
	end,
})

-- Python
api.nvim_create_autocmd('FileType', {
	pattern  = 'python',
	callback = function()
		g.python_recommended_style = 0
		set {
			expandtab  = true,
			tabstop    = 2,
			shiftwidth = 2,
		}
	end,
})

-- C/C++
api.nvim_create_autocmd('FileType', {
	pattern  = 'c,cpp',
	callback = function()
		set {
			commentstring = '// %s',
			foldmethod = 'indent',
		}
		b.minipairs_disable = true
		local opts = {noremap = true, silent = true, buffer = 0}
		map('n', '<leader>hg', function() U.include_guard(0) end , opts)
		map('i', '<C-f>', '->', opts)

		-- cmd [[TSDisable indent]] -- Treesitter indentation doesnt play very well with macros
	end
})

-- Rust, I *really* hate how rust projects insist on objectively bad indentation for accessibility
api.nvim_create_autocmd('FileType', {
	pattern = 'rust',
	callback = function()
		set {
			expandtab  = false,
			shiftwidth = 2,
			tabstop    = 2,
		}
	end,
})

-- Zig, another language that shoves bad indentation down everyone's throat.
api.nvim_create_autocmd('FileType', {
	pattern = 'zig',
	callback = function()
		local opts = {noremap = true, silent = true, buffer = 0}
		g.zig_fmt_autosave = 0
		map('n', '<C-c><C-c>', function() U.compile('zig build run') end, opts)
		map('n', '<C-c><C-t>', function() U.compile('zig build test') end, opts)
		set {
			commentstring = '// %s',
			expandtab     = true,
			tabstop       = 4,
			shiftwidth    = 4,
		}
	end
})

end
--- cmp.lua ---
do
local cmp = require 'cmp'

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
		vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
		       :sub(col, col)
		       :match('%s') == nil
end

cmp.setup {
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<Tab>'] = function(fallback)
			if not cmp.select_next_item() then
				if vim.bo.buftype ~= 'prompt' and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		end,
		['<CR>'] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources(
		{
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
		},
		{
			{ name = 'buffer' },
	 })
}
end
--- init.lua ---
do
local M = {}

M.setup = function ()
	require 'mf.options'
	require 'mf.keys'
	require 'mf.plugins'
	require 'mf.auto_cmd'
	require 'mf.nvim_theme'
	require 'mf.mini_nvim'
	require 'mf.lsp'
	require 'mf.luasnip'
	require 'mf.cmp'
	require 'mf.treesitter'
	require 'mf.nvim_tree'
	require 'mf.telescope'
	require 'mf.no_neck_pain'
	-- Useful for debugging
	P = function (t) print(vim.inspect(t)) end
end

return M
end
--- init.new.lua ---
do
end
--- keys.lua ---
do
--- Keybindings ---
local map = require 'mf.utils'.keymap

-- Remap space as leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- Q is basically useless
map("", "Q", "<Nop>")

-- Save
map("n", "<C-s>", ":w<CR>")

-- Open file to edit
map("n", "<leader>e", ":Telescope find_files<CR>")

-- Toggle file tree
map("n", "<leader>f", ":NvimTreeToggle<CR>")

-- Clear search highlight
map("n", "<leader>l", ":noh<CR>:echo<CR>")

-- Clear trailing whitespace
map("n", "<leader>W", ":%s/\\s\\+$//<CR>:noh<CR>")

-- Select all
map("n", "<C-a>", ":normal ggVG<CR>")

-- Better page up/down
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- Center text with padding
local center_width = 140
map("n", "<C-k>z", (":NoNeckPain<CR>:NoNeckPainResize %d<CR>"):format(center_width))
map("n", "<leader>z=", ":NoNeckPainWidthUp<CR>")
map("n", "<leader>z-", ":NoNeckPainWidthDown<CR>")

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
-- map("i", "<Tab>",   [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true } )
-- map("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Quick align
map("v", "<leader>a", "<ESC>:lua require 'mf.utils'.quick_align(0, nil)<CR>")

-- Toggle Pairs
map("n", "<leader><C-p>", function()
	local b = vim.b.minipairs_disable
	print(('Autopairs: %s'):format(b and 'ON' or 'OFF'))
	vim.b.minipairs_disable = not b
end)

--'<ESC>:lua QuickAlign(0, nil)<CR>')
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

end
--- lsp.lua ---
do
--- LSP configuration ---

-- Enable a server by providing a config table or using `true`
-- Disable by not providing its name or by setting it to `false`/`nil`
-- server_name = config | bool (use default config)
local enabled_servers = {
	-- Python
	pyright = true,
	-- Odin
	ols = true,
	-- Go
	gopls = true,
	-- Zig
	zls = true,
	-- Svelte
	svelte = true,
	-- HTML Snippets
	emmet_ls = true,
	-- Bash
	bashls = true,
	-- Rust
	rust_analyzer = true,
	-- C/C++
	clangd = {
		cmd = {'clangd', '-header-insertion=never'}
	},
	-- Lua
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = { globals = {'vim'}, },
				telemetry = { enable = false },
			},
		}
	},
}

local lsp_conf = require 'lspconfig'
local map = require 'mf.utils'.keymap

-- Default on_attach function, sets keybindings
local def_on_attach = function(_, bufnr)
	local opts = { noremap=true, silent=true, buffer=bufnr }
	map('n', 'gD', vim.lsp.buf.declaration, opts)
	map('n', 'gd', vim.lsp.buf.definition, opts)
	map('n', 'K', vim.lsp.buf.hover, opts)
	map('n', 'gi', vim.lsp.buf.implementation, opts)
	map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	map('n', '<leader>vrn', vim.lsp.buf.rename, opts)
	map('n', '<leader>vca', vim.lsp.buf.code_action, opts)
	map('n', '<leader>r', vim.lsp.buf.references, opts)
	map('n', '<leader>D', ':Telescope diagnostics<CR>')
	map('n', '<leader>vS', ':LspStop<CR>')
	map('n', '<leader>vR', ':LspRestart<CR>')
end

for server, cfg in pairs(enabled_servers) do
	if cfg then
		local user_conf = (type(cfg) == 'table') and cfg or {}
		if not user_conf.on_attach then
			user_conf.on_attach = def_on_attach
		end
		lsp_conf[server].setup(user_conf)
	end
end

end
--- luasnip.lua ---
do
local ls = require 'luasnip'
local map = require 'mf.utils'.keymap

map({'i', 's'}, '<C-j>', function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end)

map({'i', 's'}, '<C-k>', function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end)

map({'i', 's'}, '<C-l>', function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

map({'i', 's'}, '<C-h>', function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end)

map('i', '<C-c>', function()
	if ls.expand_or_jumpable() then
		vim.cmd [[LuaSnipUnlinkCurrent]]
		print('Snippet cancelled')
	end
end)

ls.config.set_config {
	history = false,
	updateevents = 'TextChanged,TextChangedI',
	enable_autosnippets = false,
}

local s, i, t = ls.snippet, ls.insert_node, ls.text_node
local fmt = require 'luasnip.extras.fmt'.fmt
local rep = require 'luasnip.extras'.rep
local c = ls.choice_node
local f = ls.function_node

local cpp_cons_opts = function () return { t'{}', t';', t' = default;', t' = delete;'} end
local first_lower = function(args) return args[1][1]:sub(1,1):lower() end

ls.add_snippets(nil, {
	all = {
		s('date', { c(1, {
			f(function() return os.date('%Y-%m-%d') end),
			f(function() return os.date('%Y-%m-%d %H:%M') end),
			f(function() return os.date('%H:%M') end),
			f(function() return os.date('%b %d(%a) %Y') end),
			})}),
	},
	c = {
		s('struct', fmt(
			[[
			typedef struct {} {};

			struct {} {{
				{}
			}};
			]], {i(1), rep(1), rep(1), i(0)})),
	},
	cpp = {
		s('copy', fmt(
			[[
			{}(const {}& {}){}

			{}& operator=(const {}& {}){}
			]],
			{
				i(1),
				rep(1), f(first_lower,{1}),
				c(2, cpp_cons_opts()),
				rep(1), rep(1), f(first_lower,{1}),
				c(3, cpp_cons_opts()),
			}
		)),
		s('move', fmt(
			[[
			{}({}&& {}){}

			{}& operator=({}&& {}){}
			]],
			{
				i(1),
				rep(1), f(first_lower,{1}),
				c(2, cpp_cons_opts()),

				rep(1), rep(1), f(first_lower,{1}),
				c(3, cpp_cons_opts())
			}
		)),
		s('cons', fmt(
			[[
			{}(){}

			~{}(){}
			]],
			{
				i(1),
				c(2, cpp_cons_opts()),
				rep(1), -- [[ Dtor ]]
				c(3, cpp_cons_opts()),
		})),
	}
})
end
--- mini_nvim.lua ---
do
--- Mini.nvim setup ---
-- Extend motions a/i
require 'mini.ai'.setup()

-- Surround motions
require 'mini.surround'.setup()

-- Alignment motions
require 'mini.align'.setup()

-- Statusline
require 'mini.statusline'.setup()

-- Tabline
require 'mini.tabline'.setup()

-- Comment motions
require 'mini.comment'.setup {
	mappings = {
		comment = '<leader>c',
		comment_line = '<leader>c',
	},
}

-- Auto pairs
require 'mini.pairs'.setup()
vim.g.minipairs_disable = false -- Disable by default

end
--- no_neck_pain.lua ---
do
require("no-neck-pain").setup {
	buffers = {
		colors = {
			-- Make sure 'nvim-theme' is seup before this
			text = NvimThemeOptions.colors.bg_br_alt
		}
	},
}

end
--- nvim_theme.lua ---
do
require 'nvim-theme'.setup {
	transparent = true,
	bright_cursor_line = false,
}

end
--- nvim_tree.lua ---
do
require 'nvim-tree'.setup {
	disable_netrw = true,
	hijack_netrw = true,
	sync_root_with_cwd = false,
	view = {
		cursorline = true,
		width = 32,
	},
	renderer = {
		indent_width = 2,
		indent_markers = {
			enable = true,
		},
		icons = {
			webdev_colors = false,
			modified_placement = 'before',
			padding = ' ',
			symlink_arrow = ' → ',
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = false,
				modified = true,
			},
			glyphs = {
				default = '',
				symlink = '',
				bookmark = '',
				modified = '*',
				folder = {
					arrow_closed = '',
					arrow_open = '',
					default = '',
					open = '',
					empty = '',
					empty_open = '',
					symlink = '',
					symlink_open = '',
				},
			},
		},
	},
	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
			restrict_above_cwd = false,
		},
	},
	live_filter = {
		prefix = '[FILTER]: ',
		always_show_folders = true,
	},
	ui = {
		confirm = {
			remove = true,
			trash = true,
		},
	},
}

end
--- options.lua ---
do
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

end
--- plugins.lua ---
do
-- TODO: specify install_path as var

--- Plugins ---
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('config')..'/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local packer = require 'packer'

packer.init {
	package_root = vim.fn.stdpath('config')..'/pack',
	compile_path = vim.fn.stdpath('config')..'/pack/packer/packer_compiled.lua',
}

return packer.startup(function(use)
	use 'wbthomason/packer.nvim'          -- Package manager
	use 'echasnovski/mini.nvim'           -- Many small neovim extensions
	use 'nvim-treesitter/nvim-treesitter' -- Good highlighting, folding, etc.
	use 'nvim-lua/plenary.nvim'           -- Utilities that some plugins depend on
	use 'neovim/nvim-lspconfig'           -- LSP configurations
	use 'nvim-telescope/telescope.nvim'   -- Extensible fuzzy finder
	use 'marcs-feh/nvim-theme'            -- Colorscheme
	use 'nvim-tree/nvim-tree.lua'         -- File tree
	use 'hrsh7th/nvim-cmp'                -- Completion
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use {                                 -- Center padding for lonely buffers
		'shortcuts/no-neck-pain.nvim',
		tag = '*'
	}
	use {                                 -- Sophisticated snippet engine
		"L3MON4D3/LuaSnip",
		tag = "v<CurrentMajor>.*",
	}

	if packer_bootstrap then packer.sync() end
end)

end
--- telescope.lua ---
do

local map = require 'mf.utils'.keymap
local tel = require 'telescope.builtin'

map('n', '<leader>e', tel.find_files )
map('n', '<C-f>', tel.live_grep )
end
--- treesitter.lua ---
do
--- Treesitter ---
local ts_config = require 'nvim-treesitter.configs'

ts_config.setup {
	ensure_installed = {
		-- General purpose (Systems programming)
		'c', 'cpp', 'odin','zig', 'rust',
		-- General purpose (Memory managed)
		'java', 'kotlin', 'c_sharp', 'go', 'dart','python', 'ruby',
		-- General purpose (Functional)
		'scala', 'erlang', 'elixir', 'ocaml', 'haskell', 'clojure', 'nix',
		-- Web dev
		'javascript', 'typescript', 'php',
		-- Graphics and GPU accel.
		'glsl', 'cuda',
		-- Scripting
		'lua', 'scheme', 'vim', 'fish', 'bash', 'perl',
		-- Build systems
		'make', 'ninja', 'cmake', 'meson',
		-- Markup and configuration
		'html', 'css', 'json', 'org', 'latex', 'ini', 'toml', 'yaml', 'markdown', 'dockerfile',
		-- Other
		'gitignore', 'gitcommit', 'diff', 'sql', 'awk', 'graphql', 'verilog',
	},
	ignore_install = {'phpdoc', 'javadoc', 'v'},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true,
	},
}

end
--- utils.lua ---
do
--- Utilities ---

local M = {}
local api = vim.api

-- Compile in a terminal using shell cmd
M.compile = function(shell_cmd, save)
	if save == nil then save = true end
	local height = 20

	if save then vim.cmd [[wa!]] end
	vim.cmd [[]]
	vim.cmd [[topleft split]]
	vim.cmd('horizontal resize ' .. height)
	vim.cmd('terminal '..shell_cmd)
	vim.cmd [[normal i]]
end

-- Execute one or a series of vim commands
M.vim_cmd = function (cmd)
	if type(cmd) ~= 'table' then
		cmd = { cmd }
	end
	for _, c in ipairs(cmd) do
		vim.cmd(c)
	end
end

local def_key_opts = { noremap = true, silent = true }

-- Set global keymap
M.keymap = function(mode, seq, cmd, options)
	if not options then
		options = def_key_opts
	end
	vim.keymap.set(mode, seq, cmd, options)
end

-- Use table of opt=val with setlocal
M.set_local = function (t)
	for k, v in pairs(t) do
		vim.opt_local[k] = v
	end
end

-- Use table of opt=val with set
M.set_opt = function (t)
	for k, v in pairs(t) do
		vim.opt[k] = v
	end
end

-- Use table of opt=val with setglobal
M.set_global = function (t)
	for k, v in pairs(t) do
		vim.opt_global[k] = v
	end
end

-- Set a highlight group
M.hi_set = function(name, val)
	api.nvim_set_hl(0, name, val)
end

-- Set highlight group for each key in tbl
M.hi_set_pairs = function (tbl)
	for _, p in pairs(tbl) do
		api.nvim_set_hl(0, p[1], p[2])
	end
end

-- Clear a highlight group
M.hi_clear = function(name)
	api.nvim_set_hl(0, name, {})
end

-- Overwrite highlight group properties (keeps everything else intact)
M.hi_overwrite = function (name, val)
	local gval = api.nvim_get_hl_by_name(name, {})
	for k, v in pairs(val) do
		gval[k] = v
	end
	api.nvim_set_hl(0, name, gval)
end

-- Overwrite highlight group properties for each pair in table
M.hi_overwrite_pairs = function (tbl)
	for _, p in pairs(tbl) do
		M.hi_overwrite(p[1], p[2])
	end
end

-- Link highlight group1 to group22
M.hi_link = function (group1, group2)
	api.nvim_set_hl(0, group1, {})
	M.vim_cmd { 'highlight link ' .. group1 .. ' '.. group2 }
end

-- For each pair in tbm link highlight group1 to group2
M.hi_link_pairs = function (tbl)
	for _, p in ipairs(tbl) do
		M.hi_link(p[1], p[2])
	end
end

-- Wrapper for mini.align
M.quick_align = function(buf_num, pattern)
	local from  = api.nvim_buf_get_mark(buf_num, "<")[1]
	local to    = api.nvim_buf_get_mark(buf_num, ">")[1]
	if from > to then
		from, to = to, from
	end
	if not pattern then
		pattern = vim.fn.input('Pattern: ', '', 'buffer')
	end

	local lines = api.nvim_buf_get_lines(buf_num, from - 1, to, true)

	local new_lines = MiniAlign.align_strings(lines,
		{ split_pattern = pattern, justify_side = 'left' }
	)
	api.nvim_buf_set_lines(buf_num, from - 1, to, true, new_lines)
end

-- Create an include guard for C/C++ files
M.include_guard = function(bufnum)
	local name    = api.nvim_buf_get_name(bufnum)
	local cur_pos = api.nvim_win_get_cursor(bufnum)
	name = '_' .. name:
		gsub('.*/', ''):
		gsub('%.', '_'):
		gsub('%s', ' '):
		gsub(' ', '_'):
		lower() .. '_include_'

	M.vim_cmd {
		'normal ggO#ifndef '..name,
		'normal o#define '..name,
		'normal o',
		'normal Go',
		'normal o#endif /* Include guard */',
	}
	-- Put cursor back
	api.nvim_win_set_cursor(bufnum, cur_pos)
end

return M
end
end
--- keys.lua ---
do
--- Keybindings ---
local map = require 'mf.utils'.keymap

-- Remap space as leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- Q is basically useless
map("", "Q", "<Nop>")

-- Save
map("n", "<C-s>", ":w<CR>")

-- Open file to edit
map("n", "<leader>e", ":Telescope find_files<CR>")

-- Toggle file tree
map("n", "<leader>f", ":NvimTreeToggle<CR>")

-- Clear search highlight
map("n", "<leader>l", ":noh<CR>:echo<CR>")

-- Clear trailing whitespace
map("n", "<leader>W", ":%s/\\s\\+$//<CR>:noh<CR>")

-- Select all
map("n", "<C-a>", ":normal ggVG<CR>")

-- Better page up/down
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- Center text with padding
local center_width = 140
map("n", "<C-k>z", (":NoNeckPain<CR>:NoNeckPainResize %d<CR>"):format(center_width))
map("n", "<leader>z=", ":NoNeckPainWidthUp<CR>")
map("n", "<leader>z-", ":NoNeckPainWidthDown<CR>")

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
-- map("i", "<Tab>",   [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true } )
-- map("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Quick align
map("v", "<leader>a", "<ESC>:lua require 'mf.utils'.quick_align(0, nil)<CR>")

-- Toggle Pairs
map("n", "<leader><C-p>", function()
	local b = vim.b.minipairs_disable
	print(('Autopairs: %s'):format(b and 'ON' or 'OFF'))
	vim.b.minipairs_disable = not b
end)

--'<ESC>:lua QuickAlign(0, nil)<CR>')
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

end
--- lsp.lua ---
do
--- LSP configuration ---

-- Enable a server by providing a config table or using `true`
-- Disable by not providing its name or by setting it to `false`/`nil`
-- server_name = config | bool (use default config)
local enabled_servers = {
	-- Python
	pyright = true,
	-- Odin
	ols = true,
	-- Go
	gopls = true,
	-- Zig
	zls = true,
	-- Svelte
	svelte = true,
	-- HTML Snippets
	emmet_ls = true,
	-- Bash
	bashls = true,
	-- Rust
	rust_analyzer = true,
	-- C/C++
	clangd = {
		cmd = {'clangd', '-header-insertion=never'}
	},
	-- Lua
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = { globals = {'vim'}, },
				telemetry = { enable = false },
			},
		}
	},
}

local lsp_conf = require 'lspconfig'
local map = require 'mf.utils'.keymap

-- Default on_attach function, sets keybindings
local def_on_attach = function(_, bufnr)
	local opts = { noremap=true, silent=true, buffer=bufnr }
	map('n', 'gD', vim.lsp.buf.declaration, opts)
	map('n', 'gd', vim.lsp.buf.definition, opts)
	map('n', 'K', vim.lsp.buf.hover, opts)
	map('n', 'gi', vim.lsp.buf.implementation, opts)
	map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	map('n', '<leader>vrn', vim.lsp.buf.rename, opts)
	map('n', '<leader>vca', vim.lsp.buf.code_action, opts)
	map('n', '<leader>r', vim.lsp.buf.references, opts)
	map('n', '<leader>D', ':Telescope diagnostics<CR>')
	map('n', '<leader>vS', ':LspStop<CR>')
	map('n', '<leader>vR', ':LspRestart<CR>')
end

for server, cfg in pairs(enabled_servers) do
	if cfg then
		local user_conf = (type(cfg) == 'table') and cfg or {}
		if not user_conf.on_attach then
			user_conf.on_attach = def_on_attach
		end
		lsp_conf[server].setup(user_conf)
	end
end

end
--- luasnip.lua ---
do
local ls = require 'luasnip'
local map = require 'mf.utils'.keymap

map({'i', 's'}, '<C-j>', function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end)

map({'i', 's'}, '<C-k>', function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end)

map({'i', 's'}, '<C-l>', function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

map({'i', 's'}, '<C-h>', function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end)

map('i', '<C-c>', function()
	if ls.expand_or_jumpable() then
		vim.cmd [[LuaSnipUnlinkCurrent]]
		print('Snippet cancelled')
	end
end)

ls.config.set_config {
	history = false,
	updateevents = 'TextChanged,TextChangedI',
	enable_autosnippets = false,
}

local s, i, t = ls.snippet, ls.insert_node, ls.text_node
local fmt = require 'luasnip.extras.fmt'.fmt
local rep = require 'luasnip.extras'.rep
local c = ls.choice_node
local f = ls.function_node

local cpp_cons_opts = function () return { t'{}', t';', t' = default;', t' = delete;'} end
local first_lower = function(args) return args[1][1]:sub(1,1):lower() end

ls.add_snippets(nil, {
	all = {
		s('date', { c(1, {
			f(function() return os.date('%Y-%m-%d') end),
			f(function() return os.date('%Y-%m-%d %H:%M') end),
			f(function() return os.date('%H:%M') end),
			f(function() return os.date('%b %d(%a) %Y') end),
			})}),
	},
	c = {
		s('struct', fmt(
			[[
			typedef struct {} {};

			struct {} {{
				{}
			}};
			]], {i(1), rep(1), rep(1), i(0)})),
	},
	cpp = {
		s('copy', fmt(
			[[
			{}(const {}& {}){}

			{}& operator=(const {}& {}){}
			]],
			{
				i(1),
				rep(1), f(first_lower,{1}),
				c(2, cpp_cons_opts()),
				rep(1), rep(1), f(first_lower,{1}),
				c(3, cpp_cons_opts()),
			}
		)),
		s('move', fmt(
			[[
			{}({}&& {}){}

			{}& operator=({}&& {}){}
			]],
			{
				i(1),
				rep(1), f(first_lower,{1}),
				c(2, cpp_cons_opts()),

				rep(1), rep(1), f(first_lower,{1}),
				c(3, cpp_cons_opts())
			}
		)),
		s('cons', fmt(
			[[
			{}(){}

			~{}(){}
			]],
			{
				i(1),
				c(2, cpp_cons_opts()),
				rep(1), -- [[ Dtor ]]
				c(3, cpp_cons_opts()),
		})),
	}
})
end
--- mini_nvim.lua ---
do
--- Mini.nvim setup ---
-- Extend motions a/i
require 'mini.ai'.setup()

-- Surround motions
require 'mini.surround'.setup()

-- Alignment motions
require 'mini.align'.setup()

-- Statusline
require 'mini.statusline'.setup()

-- Tabline
require 'mini.tabline'.setup()

-- Comment motions
require 'mini.comment'.setup {
	mappings = {
		comment = '<leader>c',
		comment_line = '<leader>c',
	},
}

-- Auto pairs
require 'mini.pairs'.setup()
vim.g.minipairs_disable = false -- Disable by default

end
--- no_neck_pain.lua ---
do
require("no-neck-pain").setup {
	buffers = {
		colors = {
			-- Make sure 'nvim-theme' is seup before this
			text = NvimThemeOptions.colors.bg_br_alt
		}
	},
}

end
--- nvim_theme.lua ---
do
require 'nvim-theme'.setup {
	transparent = true,
	bright_cursor_line = false,
}

end
--- nvim_tree.lua ---
do
require 'nvim-tree'.setup {
	disable_netrw = true,
	hijack_netrw = true,
	sync_root_with_cwd = false,
	view = {
		cursorline = true,
		width = 32,
	},
	renderer = {
		indent_width = 2,
		indent_markers = {
			enable = true,
		},
		icons = {
			webdev_colors = false,
			modified_placement = 'before',
			padding = ' ',
			symlink_arrow = ' → ',
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = false,
				modified = true,
			},
			glyphs = {
				default = '',
				symlink = '',
				bookmark = '',
				modified = '*',
				folder = {
					arrow_closed = '',
					arrow_open = '',
					default = '',
					open = '',
					empty = '',
					empty_open = '',
					symlink = '',
					symlink_open = '',
				},
			},
		},
	},
	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
			restrict_above_cwd = false,
		},
	},
	live_filter = {
		prefix = '[FILTER]: ',
		always_show_folders = true,
	},
	ui = {
		confirm = {
			remove = true,
			trash = true,
		},
	},
}

end
--- options.lua ---
do
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

end
--- plugins.lua ---
do
-- TODO: specify install_path as var

--- Plugins ---
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('config')..'/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local packer = require 'packer'

packer.init {
	package_root = vim.fn.stdpath('config')..'/pack',
	compile_path = vim.fn.stdpath('config')..'/pack/packer/packer_compiled.lua',
}

return packer.startup(function(use)
	use 'wbthomason/packer.nvim'          -- Package manager
	use 'echasnovski/mini.nvim'           -- Many small neovim extensions
	use 'nvim-treesitter/nvim-treesitter' -- Good highlighting, folding, etc.
	use 'nvim-lua/plenary.nvim'           -- Utilities that some plugins depend on
	use 'neovim/nvim-lspconfig'           -- LSP configurations
	use 'nvim-telescope/telescope.nvim'   -- Extensible fuzzy finder
	use 'marcs-feh/nvim-theme'            -- Colorscheme
	use 'nvim-tree/nvim-tree.lua'         -- File tree
	use 'hrsh7th/nvim-cmp'                -- Completion
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use {                                 -- Center padding for lonely buffers
		'shortcuts/no-neck-pain.nvim',
		tag = '*'
	}
	use {                                 -- Sophisticated snippet engine
		"L3MON4D3/LuaSnip",
		tag = "v<CurrentMajor>.*",
	}

	if packer_bootstrap then packer.sync() end
end)

end
--- telescope.lua ---
do

local map = require 'mf.utils'.keymap
local tel = require 'telescope.builtin'

map('n', '<leader>e', tel.find_files )
map('n', '<C-f>', tel.live_grep )
end
--- treesitter.lua ---
do
--- Treesitter ---
local ts_config = require 'nvim-treesitter.configs'

ts_config.setup {
	ensure_installed = {
		-- General purpose (Systems programming)
		'c', 'cpp', 'odin','zig', 'rust',
		-- General purpose (Memory managed)
		'java', 'kotlin', 'c_sharp', 'go', 'dart','python', 'ruby',
		-- General purpose (Functional)
		'scala', 'erlang', 'elixir', 'ocaml', 'haskell', 'clojure', 'nix',
		-- Web dev
		'javascript', 'typescript', 'php',
		-- Graphics and GPU accel.
		'glsl', 'cuda',
		-- Scripting
		'lua', 'scheme', 'vim', 'fish', 'bash', 'perl',
		-- Build systems
		'make', 'ninja', 'cmake', 'meson',
		-- Markup and configuration
		'html', 'css', 'json', 'org', 'latex', 'ini', 'toml', 'yaml', 'markdown', 'dockerfile',
		-- Other
		'gitignore', 'gitcommit', 'diff', 'sql', 'awk', 'graphql', 'verilog',
	},
	ignore_install = {'phpdoc', 'javadoc', 'v'},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true,
	},
}

end
--- utils.lua ---
do
--- Utilities ---

local M = {}
local api = vim.api

-- Compile in a terminal using shell cmd
M.compile = function(shell_cmd, save)
	if save == nil then save = true end
	local height = 20

	if save then vim.cmd [[wa!]] end
	vim.cmd [[]]
	vim.cmd [[topleft split]]
	vim.cmd('horizontal resize ' .. height)
	vim.cmd('terminal '..shell_cmd)
	vim.cmd [[normal i]]
end

-- Execute one or a series of vim commands
M.vim_cmd = function (cmd)
	if type(cmd) ~= 'table' then
		cmd = { cmd }
	end
	for _, c in ipairs(cmd) do
		vim.cmd(c)
	end
end

local def_key_opts = { noremap = true, silent = true }

-- Set global keymap
M.keymap = function(mode, seq, cmd, options)
	if not options then
		options = def_key_opts
	end
	vim.keymap.set(mode, seq, cmd, options)
end

-- Use table of opt=val with setlocal
M.set_local = function (t)
	for k, v in pairs(t) do
		vim.opt_local[k] = v
	end
end

-- Use table of opt=val with set
M.set_opt = function (t)
	for k, v in pairs(t) do
		vim.opt[k] = v
	end
end

-- Use table of opt=val with setglobal
M.set_global = function (t)
	for k, v in pairs(t) do
		vim.opt_global[k] = v
	end
end

-- Set a highlight group
M.hi_set = function(name, val)
	api.nvim_set_hl(0, name, val)
end

-- Set highlight group for each key in tbl
M.hi_set_pairs = function (tbl)
	for _, p in pairs(tbl) do
		api.nvim_set_hl(0, p[1], p[2])
	end
end

-- Clear a highlight group
M.hi_clear = function(name)
	api.nvim_set_hl(0, name, {})
end

-- Overwrite highlight group properties (keeps everything else intact)
M.hi_overwrite = function (name, val)
	local gval = api.nvim_get_hl_by_name(name, {})
	for k, v in pairs(val) do
		gval[k] = v
	end
	api.nvim_set_hl(0, name, gval)
end

-- Overwrite highlight group properties for each pair in table
M.hi_overwrite_pairs = function (tbl)
	for _, p in pairs(tbl) do
		M.hi_overwrite(p[1], p[2])
	end
end

-- Link highlight group1 to group22
M.hi_link = function (group1, group2)
	api.nvim_set_hl(0, group1, {})
	M.vim_cmd { 'highlight link ' .. group1 .. ' '.. group2 }
end

-- For each pair in tbm link highlight group1 to group2
M.hi_link_pairs = function (tbl)
	for _, p in ipairs(tbl) do
		M.hi_link(p[1], p[2])
	end
end

-- Wrapper for mini.align
M.quick_align = function(buf_num, pattern)
	local from  = api.nvim_buf_get_mark(buf_num, "<")[1]
	local to    = api.nvim_buf_get_mark(buf_num, ">")[1]
	if from > to then
		from, to = to, from
	end
	if not pattern then
		pattern = vim.fn.input('Pattern: ', '', 'buffer')
	end

	local lines = api.nvim_buf_get_lines(buf_num, from - 1, to, true)

	local new_lines = MiniAlign.align_strings(lines,
		{ split_pattern = pattern, justify_side = 'left' }
	)
	api.nvim_buf_set_lines(buf_num, from - 1, to, true, new_lines)
end

-- Create an include guard for C/C++ files
M.include_guard = function(bufnum)
	local name    = api.nvim_buf_get_name(bufnum)
	local cur_pos = api.nvim_win_get_cursor(bufnum)
	name = '_' .. name:
		gsub('.*/', ''):
		gsub('%.', '_'):
		gsub('%s', ' '):
		gsub(' ', '_'):
		lower() .. '_include_'

	M.vim_cmd {
		'normal ggO#ifndef '..name,
		'normal o#define '..name,
		'normal o',
		'normal Go',
		'normal o#endif /* Include guard */',
	}
	-- Put cursor back
	api.nvim_win_set_cursor(bufnum, cur_pos)
end

return M
end
