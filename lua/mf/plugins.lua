--- Plugins ---
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('config')..'/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local packer = require 'packer'

packer.init {
	package_root = vim.fn.stdpath('config')..'/pack',
	compile_path = vim.fn.stdpath('config')..'/pack/packer/packer_compiled.lua',
}

return packer.startup(function(use)
	use 'wbthomason/packer.nvim'          -- Package manager
	use 'echasnovski/mini.nvim'           -- Many small neovim extensions
	use 'nvim-treesitter/nvim-treesitter' -- Good highlighting, folding, etc.
	use 'nvim-lua/plenary.nvim'           -- Utilities that some plugins depend on
	use 'neovim/nvim-lspconfig'           -- LSP configurations
	use 'nvim-telescope/telescope.nvim'   -- Extensible fuzzy finder
	use 'marcs-feh/nvim-theme'            -- Colorscheme
	use 'nvim-tree/nvim-tree.lua'         -- File tree
	use 'hrsh7th/nvim-cmp'                -- Completion
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use {                                 -- Center padding for lonely buffers
		'shortcuts/no-neck-pain.nvim',
		tag = '*'
	}
	use {                                 -- Sophisticated snippet engine
		"L3MON4D3/LuaSnip",
		tag = "v<CurrentMajor>.*",
	}

	if packer_bootstrap then packer.sync() end
end)

