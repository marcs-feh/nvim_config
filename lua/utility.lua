local M = {}

local api = vim.api
local cmd = vim.cmd

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
	cmd('highlight link ' .. group1 .. ' '.. group2)
end

-- For each pair in tbm link highlight group1 to group2
M.hi_link_pairs = function (tbl)
	for _, p in ipairs(tbl) do
		cmd('highlight link ' .. p[1] .. ' '.. p[2])
	end
end

return M
