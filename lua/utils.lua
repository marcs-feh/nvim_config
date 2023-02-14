--- Utilities ---
local M = {}
local def_key_opts = { noremap = true, silent = true }

M.keymap = function(mode, seq, cmd, options)
	if not options then
		options = def_key_opts
	end
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

M.quick_align = function(buf_num, pattern)
	pattern = pattern or vim.fn.input('Pattern: ', '', 'buffer')
	local from = vim.api.nvim_buf_get_mark(buf_num, "<")[1]
	local to = vim.api.nvim_buf_get_mark(buf_num, ">")[1]
	local lines = vim.api.nvim_buf_get_lines(buf_num, from - 1, to, true)
	local new_lines = MiniAlign.align_strings(lines,
		{ split_pattern = pattern, justify_side = 'left' })

	vim.api.nvim_buf_set_lines(0, from - 1, to, true, new_lines)
end



return M
