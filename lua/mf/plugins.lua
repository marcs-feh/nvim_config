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
  use 'wbthomason/packer.nvim'
	use 'echasnovski/mini.nvim'
	use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'

  if packer_bootstrap then packer.sync() end
end)



