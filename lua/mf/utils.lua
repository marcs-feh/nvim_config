--- Utilities ---

local M = {}
local api = vim.api
local cmd = vim.cmd

local def_key_opts = { noremap = true, silent = true }
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
	cmd('highlight link ' .. group1 .. ' '.. group2)
end

-- For each pair in tbm link highlight group1 to group2
M.hi_link_pairs = function (tbl)
	for _, p in ipairs(tbl) do
		M.hi_link(p[1], p[2])
	end
end

-- Wrapper for mini.align
M.quick_align = function(buf_num, pattern)
	pattern = pattern or vim.fn.input('Pattern: ', '', 'buffer')
	local from  = api.nvim_buf_get_mark(buf_num, "<")[1]
	local to    = api.nvim_buf_get_mark(buf_num, ">")[1]
	local lines = api.nvim_buf_get_lines(buf_num, from - 1, to, true)

	local new_lines = MiniAlign.align_strings(lines,
		{ split_pattern = pattern, justify_side = 'left' })
	api.nvim_buf_set_lines(0, from - 1, to, true, new_lines)
end

return M
