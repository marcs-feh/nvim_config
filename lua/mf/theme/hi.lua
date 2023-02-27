local H = {}
local api = vim.api

-- Set a highlight group
H.hi_set = function(name, val)
	api.nvim_set_hl(0, name, val)
end

-- Set highlight group for each key in tbl
H.hi_set_pairs = function (tbl)
	for _, p in pairs(tbl) do
		if not p[2] then p[2] = {} end
		api.nvim_set_hl(0, p[1], p[2])
	end
end

return H
