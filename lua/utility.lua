local M = {}

-- Set a highlight group
function M.hi(name, val)
	vim.api.nvim_set_hl(0, name, val)
end

-- Set highlight group for each key in tbl
function M.hi_pairs(tbl)
	for group, val in pairs(tbl) do
		vim.api.nvim_set_hl(0, group, val)
	end
end

-- Link highlight group1 to group22
function M.hi_link(group1, group2)
	vim.cmd('highlight link ' .. group1 .. ' '.. group2)
end

-- For each pair in tbm link highlight group1 to group2
function M.hi_link_pairs(tbl)
	for _, p in ipairs(tbl) do
		vim.cmd('highlight link ' .. p[1] .. ' '.. p[2])
	end
end

return M
