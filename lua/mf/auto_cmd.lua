--- Auto commands ---

local U = require 'mf.utils'
local set, map = U.set_local, U.keymap
local api = vim.api
local g   = vim.g

-- Indent sensitive languages and/or languages that look weird with hard tabs
local indented_lang_opts = function()
	set {
		expandtab = true,
	}
end

-- Python specific options
local python_opts = function()
	g.python_recommended_style = 0
	set {
		expandtab = true,
		tabstop = 2,
		shiftwidth = 2,
	}
end

-- C/C++ specific options
local c_opts = function()
	set {
		commentstring = '// %s',
	}
	local opts = {noremap = true, silent = true, buffer = 0}
	map ('n', '<leader>G', function() U.include_guard(0) end , opts)
	map ('n', '<leader>M', function() U.cpp_methods() end , opts)
	map ('i', '<C-s>', 'this->', opts)
end

api.nvim_create_autocmd('FileType', {
	pattern  = 'python',
	callback = python_opts,
})

api.nvim_create_autocmd('FileType', {
	pattern  = 'markdown,ninja,scheme,org,python,nim',
	callback = indented_lang_opts,
})

api.nvim_create_autocmd('FileType', {
	pattern  = 'c,cpp',
	callback = c_opts,
})

