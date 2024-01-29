---| Utilities |---
local utils = {}
utils = {
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

	local github = function(name)
		return { url = ('http://github.com/%s'):format(name) }
	end

	local sourcehut = function(name)
		return { url = ('http://git.sr.ht/%s'):format(name) }
	end

	local plugins = {
		github 'wbthomason/packer.nvim',          -- Package manager
		github 'echasnovski/mini.nvim',           -- Many small neovim extensions
		github 'nvim-treesitter/nvim-treesitter', -- Good highlighting, folding, etc.
		github 'nvim-lua/plenary.nvim',           -- Utilities that some plugins depend on
		github 'neovim/nvim-lspconfig',           -- LSP configurations
		github 'nvim-telescope/telescope.nvim',   -- Extensible fuzzy finder
		github 'marcs-feh/colors-22.nvim',        -- Colorscheme
		github 'marcs-feh/compile.nvim',          -- Compile code with a keybinding
		sourcehut '~whynothugo/lsp_lines.nvim',   -- Prettier LSP diagnostics
	}

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

---| Colorscheme |---
do
	require 'colors-22'.setup {
		transparent = true,
		bright_cursor_line = false,
		--[[
		colors = {
			-- Main colors
			bg        = '#000000',
			bg_alt    = '#222222',
			bg_br     = '#444444',
			bg_br_alt = '#666666',
			fg        = '#eeeeee',
			fg_alt    = '#dddddd',
			fg_br     = '#fcfcfc',
			fg_br_alt = '#ffffff',

			-- Highlights
			type         = '#20aaed',
			type_alt     = '#eeeeee',
			reserved     = '#ed2055',
			reserved_alt = '#ed8055',
			id           = '#eeeeee',
			id_alt       = '#eeeeee',
			literal      = '#eeeeee',
			literal_alt  = '#eeeeee',
			func         = '#eeeeee',
			func_alt     = '#eeeeee',
			str          = '#45c510',
			str_alt      = '#50dd20',

			-- Diagnostic
			error = '#d83e33',
			warn  = '#f2ba41',
			hint  = '#cda1ac',
			info  = '#c8889f',
		}
		--]]
	}
end

---| Treesitter |---
do
	local ts_config = require 'nvim-treesitter.configs'

	ts_config.setup {
		sync_install = false, -- Enable if you have <8GB RAM, will take much longer to compile
		ensure_installed = {
			-- General purpose (Systems programming)
			'c', 'cpp', 'odin', 'zig', 'rust', 'ada',
			-- General purpose (Memory managed)
			'java', 'c_sharp', 'go', 'python', 'ruby',
			-- General purpose (Functional)
			'erlang', 'elixir', 'ocaml', 'haskell', 'clojure', 'commonlisp',
			-- Web dev
			'javascript', 'typescript', 'php',
			-- Graphics and GPU accel.
			'glsl', 'cuda', 'hlsl',
			-- Scripting
			'lua', 'scheme', 'vim', 'fish', 'bash', 'perl',
			-- Build systems
			'make', 'ninja', 'cmake', 'meson',
			-- Markup and configuration
			'html', 'xml', 'css', 'json', 'jsonc', 'org', 'latex', 'ini', 'toml', 'yaml', 'markdown', 'dockerfile',
			-- Other
			'gitignore', 'csv', 'diff', 'sql', 'awk', 'graphql', 'verilog', 'nix',
			--]]
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
			-- vim.cmd [[TSDisable indent]]
		end
	})

	-- TODO: Remove when real typst support is added
	-- Typst
	add_autocmd({ 'BufEnter', 'BufNew' }, {
		pattern  = '*.typ',
		callback = function()
			set {
				filetype = 'markdown',
				commentstring = '// %s',
			}
			-- b.minipairs_disable = true
		end
	})

	-- C3
	add_autocmd({ 'BufEnter', 'BufNew' }, {
		pattern  = '*.c3',
		callback = function()
			set {
				filetype = 'c3',
				expandtab = false,
				commentstring = '// %s',
			}
			b.minipairs_disable = true
		end
	})

	-- GLSL
	add_autocmd({ 'BufEnter', 'BufNew' }, {
		pattern  = { '*.glsl', '*.vert', '*.frag', '*.tesc',
			          '*.tese', '*.geom', '*.comp', },
		callback = function()
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
			map('i', '<C-f>', '->', opts)

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
	capabilities.textDocument.completion.completionItem.snippetSupport = true

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
		rust_analyzer = false,
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
	vim.g.minipairs_disable = false -- Disable by default

	-- Completion
	require 'mini.completion'.setup{}
end

---| Telescope |---
do
	local map = utils.keymap
	local tele = require 'telescope.builtin'

	map('n', '<leader>e', tele.find_files )
	map('n', '<C-f>', tele.live_grep )

end

---| Compile.nvim |---
do
	-- Mild optimizations, made to be quick to compile and run locally
	local odin_cmd = "odin %s . -collection:shared=. -debug -use-separate-modules -o:minimal -thread-count:$(nproc) -reloc-mode:pic -microarch:native"
	require 'compile'.setup {
		language_commands = {
			['odin'] = {
				build = odin_cmd:format('build'),
				run = odin_cmd:format('run'),
				test = odin_cmd:format('test'),
			},
			['zig'] = {
				build = 'zig build',
				run = 'zig build run',
				test = 'zig build test',
			},
			['cpp'] = {
				build = 'make build',
				run = 'make run',
				test = 'make test',
			},
			['c'] = {
				build = 'make build',
				run = 'make run',
				test = 'make test',
			},
		},
	}
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

