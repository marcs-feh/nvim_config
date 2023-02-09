--- Utilities ---
local M = {}
local def_key_opts = { noremap = true, silent = true }

M.keymap = function(mode, seq, cmd, options)
	if not options then
		options = def_key_opts
	end
 vim.keymap.set(mode, seq, cmd, options)
end

M.keymap_local = function(mode, seq, cmd, options)
	if not options then
		options = def_key_opts
	end
	options['buffer'] = 0 -- Use current buffer
	vim.keymap.set(mode, seq, cmd, options)
end

M.set_local = function (t)
	for k, v in pairs(t) do
		vim.opt_local[k] = v
	end
end

M.set_opt = function (t)
	for k, v in pairs(t) do
		vim.opt[k] = v
	end
end

M.set_global = function (t)
	for k, v in pairs(t) do
		vim.opt_global[k] = v
	end
end

return M
