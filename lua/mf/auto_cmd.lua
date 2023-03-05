--- Auto commands ---
local U   = require 'mf.utils'
local api = vim.api
local g   = vim.g
local cmd = vim.cmd
local set = U.set_local
local map = U.keymap

-- Indent sensitive languages and/or languages that look weird with hard tabs
api.nvim_create_autocmd('FileType', {
	pattern  = 'markdown,ninja,scheme,org,python,nim,lisp,sml',
	callback = function()
		set {
			expandtab = true,
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
		local opts = {noremap = true, silent = true, buffer = 0}
		map('n', '<leader>G', function() U.include_guard(0) end , opts)
		map('n', '<leader>M', function() U.cpp_methods() end , opts)
		map('i', '<C-f>', '->', opts)
		-- cmd [[TSDisable indent]] -- Treesitter indentation doesnt play very well with macros
	end
})



