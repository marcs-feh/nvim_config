--- Auto commands ---

local set_local = require 'utils'.set_local
local api = vim.api
local g   = vim.g

-- Indent sensitive languages and/or languages that look weird with hard tabs
local indented_lang_opts = function()
	set_local {
		expandtab = true,
	}
end

-- Python specific options
local python_opts = function()
	g.python_recommended_style = 0
	set_local {
		expandtab = true,
		tabstop = 2,
		shiftwidth = 2,
	}
end

-- C/C++ specific options
local c_opts = function()
	set_local {
		commentstring = '// %s',
	}
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

