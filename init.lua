---| Utilities |---
local utils = {}

utils = {
	get_group_fg = function(groupname)
		return vim.fn.synIDattr(vim.fn.hlID(groupname), 'fg')
	end,

	get_group_bg = function(groupname)
		return vim.fn.synIDattr(vim.fn.hlID(groupname), 'bg')
	end,

	set_opt = function(t, scope)
		if not scope then scope = 'default' end
		local opt_map = {
			['default'] = 'opt',
			['local']   = 'opt_local',
			['global']  = 'opt_global',
		}
		local opt = opt_map[scope]
		assert(opt, 'Unknown value for config scope')
		for k, v in pairs(t) do
			vim[opt][k] = v
		end
	end,

	vim_cmd = function(cmds)
		for _, c in ipairs(cmds)do
			vim.cmd(c)
		end
	end,

	keymap = function(mode, seq, cmd, options)
		if not options then
			options = {noremap = true, silent = true}
		end
		vim.keymap.set(mode, seq, cmd, options)
	end,

	quick_align = function(buf_num, pattern)
		local from  = vim.api.nvim_buf_get_mark(buf_num, "<")[1]
		local to    = vim.api.nvim_buf_get_mark(buf_num, ">")[1]
		if from > to then
			from, to = to, from
		end
		if not pattern then
			pattern = vim.fn.input('Pattern: ', '', 'buffer')
		end

		local lines = vim.api.nvim_buf_get_lines(buf_num, from - 1, to, true)

		local new_lines = MiniAlign.align_strings(lines,
			{ split_pattern = pattern, justify_side = 'left' })
		vim.api.nvim_buf_set_lines(buf_num, from - 1, to, true, new_lines)
	end,

	-- Create an include guard for C/C++ files
	include_guard = function(bufnum)
		local name    = vim.api.nvim_buf_get_name(bufnum)
		local cur_pos = vim.api.nvim_win_get_cursor(bufnum)
		name = '_' .. name
			:gsub('.*/', '')
			:gsub('%.', '_')
			:gsub('%s', ' ')
			:gsub('%-', '_')
			:gsub(' ', '_')
		:lower() .. '_include_'

		utils.vim_cmd {
			'normal ggO#ifndef '..name,
			'normal o#define '..name,
			'normal o',
			'normal Go',
			'normal o#endif /* Include guard */',
		}
		-- Put cursor back
		vim.api.nvim_win_set_cursor(bufnum, cur_pos)
	end,
}

---| Options |---
do
	local set = function(opt) utils.set_opt(opt) end
	local tabsize = 4
	set {
		-- Creates a backup file
		backup = false,
		-- Required to keep multiple buffers open
		hidden = true,
		-- Allows neovim to access the system clipboard
		clipboard = "unnamedplus",
		-- Command line height
		cmdheight = 1,
		-- Don't lock neovim if too much text is printed
		more = false,
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
		tabstop = tabsize,
		-- The number of spaces inserted for each indentation
		shiftwidth = tabsize,
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

	-- Netrw options
	vim.g.netrw_keepdir = 0
	vim.g.netrw_banner  = 0
	vim.g.netrw_hide    = 1
	vim.g.netrw_winsize = 30
end

---| Plugins |---
do
	local lazyroot = vim.fn.stdpath("config") .. "/lazy"
	local lazypath = lazyroot .. "/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
	  vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	  })
	end
	vim.opt.runtimepath:prepend(lazypath)

	local github = function(name, branch)
		return { url = ('http://github.com/%s'):format(name), branch = branch }
	end

	local sourcehut = function(name, branch)
		return { url = ('http://git.sr.ht/%s'):format(name), branch = branch }
	end

	local plugins = {
		github 'echasnovski/mini.nvim',           -- Many small neovim extensions
		github 'nvim-treesitter/nvim-treesitter', -- Good highlighting, folding, etc.
		github 'neovim/nvim-lspconfig',           -- LSP configurations
		github 'nvim-telescope/telescope.nvim',   -- Extensible fuzzy finder
		github 'marcs-feh/vim-compile',           -- Compile files inside neovim
		github 'marcs-feh/udark.vim',             -- VS style dark theme
		sourcehut '~whynothugo/lsp_lines.nvim',   -- Prettier LSP diagnostics
	}


	-- Icons copied form the default config
	require 'lazy'.setup(plugins, {
		root = lazyroot,
		ui = { icons = { cmd = "⌘", config = "🛠", event = "📅", ft = "📂", init = "⚙", keys = "🗝", plugin = "🔌", runtime = "💻", require = "🌙", source = "📄", start = "🚀", task = "📌", lazy = "💤 ", }, },
	})
end

---| Keybindings |---
do
	local map = utils.keymap
	-- Remap space as leader key
	map("", "<Space>", "<Nop>")
	vim.g.mapleader      = " "
	vim.g.maplocalleader = " "

	-- Q is basically useless
	map("", "Q", "<Nop>")

	-- Save
	map("n", "<C-s>", ":w<CR>")
	map("i", "<C-s>", "<ESC>:w<CR>")

	-- Open file to edit
	map("n", "<leader>e", ":Telescope find_files<CR>")

	-- Toggle Netrw
	map("n", "<leader>f", ":Lexplore<CR>")

	-- Clear search highlight
	map("n", "<leader>l", ":noh<CR>:echo<CR>")

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

	-- Alternative page up and down
	map("n", "<C-k>", "<C-u>")
	map("n", "<C-j>", "<C-d>")

	-- Expand window
	map("n", "<leader>F", ":resize<CR>:vertical resize<CR>")

	-- Better window navigation
	map("n", "<A-h>", "<C-w>h")
	map("n", "<A-j>", "<C-w>j")
	map("n", "<A-k>", "<C-w>k")
	map("n", "<A-l>", "<C-w>l")
	map("n", "<C-o>", "<C-w>w")
	map("n", "<leader>q", ":close<CR>")

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
	map("n", "<leader>n", ":enew<CR>")
	map("n", "<leader>x", ":bdelete<CR>")
	map("n", "<leader>X", ":bdelete!<CR>")

	-- Navigate tabs
	map("n", "<C-Tab>", ":tabnext<CR>")
	map("n", "<C-S-Tab>", ":tabprevious<CR>")
	map("n", "<leader><C-t>", ":tabnew<CR>")
	map("n", "<leader><C-x>", ":tabclose<CR>")

	-- Mini.completion (uncomment if not using cmp)
	map("i", "<Tab>",   [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { noremap = true, expr = true } )
	map("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

	-- Insert block
	map("i", "<C-b>", "{}<ESC>i<CR><ESC>O")

	-- Stay in indent mode
	map("v", "<", "<gv")
	map("v", ">", ">gv")

	-- Quick align
	map("v", "<leader>a", "<ESC>:lua QuickAlign(0, nil)<CR>")

	-- Toggle Pairs
	map("n", "<leader><C-p>", function()
		local b = vim.b.minipairs_disable
		print(('Autopairs: %s'):format(b and 'ON' or 'OFF'))
		vim.b.minipairs_disable = not b
	end)

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

---| Colorscheme |---
do
	vim.cmd [[colors udark]]
	vim.cmd [[hi! Normal guibg=#181818]]
	vim.cmd [[hi! SignColumn guibg=NONE]]
end

---| Treesitter |---
do
	local ts_config = require 'nvim-treesitter.configs'

	ts_config.setup {
		sync_install = true, -- Enable if you have <8GB RAM, will take much longer to compile
		ensure_installed = {
			'c', 'cpp', 'odin', 'zig', 'rust', 'ada', 'pascal', 'go', 'python',
			'erlang', 'elixir', 'ocaml', 'lua', 'vim', 'bash','sql', 'markdown',
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

---| Autocmds |---
do
	local api = vim.api
	local g, b = vim.g, vim.b
	local map = utils.keymap
	local set = function(opts) utils.set_opt(opts, 'local') end
	local add_autocmd = api.nvim_create_autocmd

	-- Indent sensitive languages and/or languages that look weird with hard tabs
	add_autocmd('FileType', {
		pattern  = 'markdown,ninja,scheme,org,python,nim,lisp,sml,clojure,vim',
		callback = function()
			set {
				expandtab  = true,
				tabstop    = 2,
				shiftwidth = 2,
			}
		end
	})

	-- Odin
	add_autocmd('FileType', {
		pattern  = 'odin',
		callback = function()
			set {
				expandtab = false,
				commentstring = '// %s',
			}
			b.minipairs_disable = true
			-- Indentation is kinda broken in odin-treesitter
			vim.cmd [[TSBufDisable indent]]
		end
	})

	-- TODO: Remove when real typst support is added
	-- Typst
	add_autocmd({ 'BufEnter' }, {
		pattern  = '*.typ',
		callback = function()
			set {
				filetype = 'markdown',
				commentstring = '// %s',
			}
			-- b.minipairs_disable = true
		end
	})

	-- GLSL
	add_autocmd({ 'BufEnter' }, {
		pattern  = { '*.glsl', '*.vert', '*.frag', '*.tesc',
			          '*.tese', '*.geom', '*.comp', },
		callback = function()
			print(vim.api.nvim_get_current_buf())
			set {
				filetype = 'glsl',
				commentstring = '// %s',
			}
			b.minipairs_disable = true
		end
	})

	-- No autopairs
	add_autocmd('FileType', {
		pattern = 'bash,zsh,sh,fish,ps1,markdown',
		callback = function()
			b.minipairs_disable = true
		end
	})

	-- Netrw
	add_autocmd('FileType', {
		pattern = 'netrw',
		callback = function()
			map('n', 'cd', ':cd %<CR>', { buffer = true, silent = true, noremap = true })
		end
	})

	-- LISPs
	add_autocmd('FileType', {
		pattern = 'scheme,clojure,lisp',
		callback = function()
			MiniPairs.unmap('i', "'", "''")
		end
	})

	-- SQL
	add_autocmd('FileType', {
		pattern  = 'sql',
		callback = function()
			set {
				expandtab = true,
				commentstring = '--%s',
			}
		end
	})

	-- XML, HTML
	add_autocmd('FileType', {
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
	add_autocmd('FileType', {
		pattern  = 'python',
		callback = function()
			b.minipairs_disable = true
			set {
				expandtab  = true,
				tabstop    = 4,
				shiftwidth = 4,
			}
		end,
	})

	-- C/C++
	add_autocmd('FileType', {
		pattern  = 'c,cpp',
		callback = function()
			set {
				commentstring = '// %s',
				foldmethod = 'indent',
			}
			b.minipairs_disable = true
			local opts = {noremap = true, silent = true, buffer = 0}
			map('n', '<leader>hg', function() utils.include_guard(0) end , opts)
			map('i', '<C-l>', '->', opts)

			-- cmd [[TSDisable indent]] -- Treesitter indentation doesnt play very well with macros
		end
	})

	-- Zig
	add_autocmd('FileType', {
		pattern = 'zig',
		callback = function()
			g.zig_fmt_autosave = 0
			b.minipairs_disable = true
			set {
				commentstring = '// %s',
			}
		end
	})

end

---| LSP |---
do
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = false

	-- Enable a server by providing a config table or using `true`
	-- Disable by not providing its name or by setting it to `false`/`nil`
	local enabled_servers = {
		-- Python
		pyright = true,
		-- Odin
		ols = true,
		-- OCaml
		ocamlls = true,
		-- Go
		gopls = true,
		-- Zig
		zls = true,
		-- Svelte
		svelte = true,
		-- HTML
		emmet_ls = true,
		-- Bash
		bashls = false,
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
	local map = utils.keymap

	-- Default on_attach, sets keybindings
	local def_on_attach = function(_, bufnr)
		local opts = { noremap=true, silent=true, buffer=bufnr }
		map('n', 'gD', vim.lsp.buf.declaration, opts)
		map('n', 'gd', vim.lsp.buf.definition, opts)
		map('n', 'K', vim.lsp.buf.hover, opts)
		map('n', 'gi', vim.lsp.buf.implementation, opts)
		map('n', '<leader>vk', vim.lsp.buf.signature_help, opts)
		map('n', '<leader>vrn', vim.lsp.buf.rename, opts)
		map('n', '<leader>vca', vim.lsp.buf.code_action, opts)
		map('n', '<leader>r', vim.lsp.buf.references, opts)
		map('n', '<leader>D', ':Telescope diagnostics<CR>')
		map('n', '<leader>vS', ':LspStop<CR>')
		map('n', '<leader>vR', ':LspRestart<CR>')
		map('n', '<leader>ve', vim.diagnostic.setqflist)
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

---| vim-compile |---
do
	vim.cmd[[call compile#defaultMappings()]]
end
---| Mini.nvim |---
do
	-- Extend motions a/i
	require 'mini.ai'.setup()

	-- Surround motions
	require 'mini.surround'.setup()

	-- Alignment motions
	require 'mini.align'.setup()

	-- Statusline
	require 'mini.statusline'.setup{
		use_icons = false,
	}

	local bg_col      = utils.get_group_bg('Normal')
	local type_col    = utils.get_group_fg('Type')
	local comment_col = utils.get_group_fg('Comment')
	local const_col   = utils.get_group_fg('Constant')
	local keyword_col = utils.get_group_fg('Keyword')

	vim.cmd(("hi! MiniStatuslineModeNormal  guifg='%s' guibg='%s'"):format(bg_col, type_col))
	vim.cmd(("hi! MiniStatuslineModeVisual  guifg='%s' guibg='%s'"):format(bg_col, comment_col))
	vim.cmd(("hi! MiniStatuslineModeInsert  guifg='%s' guibg='%s'"):format(bg_col, const_col))
	vim.cmd(("hi! MiniStatuslineModeCommand guifg='%s' guibg='%s'"):format(bg_col, keyword_col))

	-- Tabline
	require 'mini.tabline'.setup()

	-- Comment motions
	require 'mini.comment'.setup {
		mappings = {
			comment = '<leader>c',
			comment_line = '<leader>c',
			comment_visual = '<leader>c',
		},
	}

	-- Auto pairs
	require 'mini.pairs'.setup()
	vim.g.minipairs_disable = true -- Disable by default

	-- Completion
	require 'mini.completion'.setup{
		lsp_completion = {
			auto_setup = false,
		}
	}
end

---| Telescope |---
do
	local map = utils.keymap
	local tele = require 'telescope.builtin'

	map('n', '<leader>e', tele.find_files )
	map('n', '<C-f>', tele.live_grep )

end

---| LSP Lines |---
do
	require 'lsp_lines'.setup()
	--- Give LSP lines control over virtual lines
	vim.diagnostic.config{
		virtual_text = false,
		virtual_lines = {
			only_current_line = true,
		},
	}
end

---| Global Exports |---
do
	QuickAlign = utils.quick_align
	function P(x) print(vim.inspect(x)) end
end

