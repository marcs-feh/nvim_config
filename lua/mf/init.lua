local M = {}

M.setup = function ()
	require 'mf.options'
	require 'mf.keys'
	require 'mf.auto_cmd'
	require 'mf.plugins'
	require 'mf.nvim_theme'
	require 'mf.treesitter'
	require 'mf.mini_nvim'
	require 'mf.lsp'
	require 'mf.cmp'
	require 'mf.nvim_tree'
	require 'mf.telescope'
	require 'mf.no_neck_pain'
	-- Useful for debugging
	P = function (t) print(vim.inspect(t)) end
end

return M
