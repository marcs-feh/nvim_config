--- Auto commands ---
local U   = require 'mf.utils' local api = vim.api
local g   = vim.g
local b   = vim.b
local cmd = vim.api.nvim_command
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
			shiftwidth = 4,
			tabstop    = 4,
		}
	end,
})

-- Zig, another language that shoves shit indentation down everyone's throat.
-- zig fmt is *literally* satan.
api.nvim_create_autocmd('FileType', {
	pattern = 'zig',
	callback = function()
		g.zig_fmt_autosave = 0
		set {
			commentstring = '// %s',
			expandtab     = false,
			tabstop       = 4,
			shiftwidth    = 4,
		}
	end
})

