--- Utilities ---

local M = {}
local api = vim.api

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

-- Clear a highlight group
M.hi_clear = function(name)
	api.nvim_set_hl(0, name, {})
end

-- Set a highlight group
M.hi_set = function(name, val)
	api.nvim_set_hl(0, name, val)
end

-- Set highlight group for each key in tbl
M.hi_set_pairs = function (tbl)
	for group, val in pairs(tbl) do
		api.nvim_set_hl(0, group, val)
	end
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
	pattern = pattern or vim.fn.input('Pattern: ', '', 'buffer')
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
	name = 'INCLUDE_' .. name:
		gsub('.*/', ''):
		gsub('%.', '_'):
		upper() .. '_'

	M.vim_cmd {
		'normal ggO#ifndef '..name,
		'normal o#define '..name,
		'normal o',
		'normal Go',
		'normal o#endif /* include guard */',
	}
	-- Put cursor back
	api.nvim_win_set_cursor(bufnum, cur_pos)
end

-- Create constructors, assignment and destructor
M.cpp_methods = function()
	local class = vim.fn.input('Type name: ', '', 'buffer')
	if not class:match('%S+') then return end
	local lines = {
		'// Default constructor',
		class..'(){}',
		'',
		'// Copy constructor',
		class..'(const '..class..'&){}',
		'',
		'// Copy assignment',
		'void operator=(const '..class..'&){}',
		'',
		'// Move constructor',
		class..'('..class..'&&){}',
		'',
		'// Move assignment',
		'void operator=('..class..'&&){}',
		'',
	}

		for _, line in ipairs(lines) do
			M.vim_cmd { 'norm o'..line }
		end
end

return M
