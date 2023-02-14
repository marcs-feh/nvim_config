--- LSP configuration ---

-- Enable a server by providing a config table or using `true`
-- Disable by not providing its name or by setting it to `false`/`nil`
-- server_name = config | bool
local enabled_servers = {
	pyright     = true,
	clangd      = true,
	emmet_ls    = true,
	bashls      = true,
	sumneko_lua = true,
}

local lsp_conf = require 'lspconfig'
local map = require 'utils'.keymap

-- Default on_attach function, sets keybindings
local def_on_attach = function(client, bufnr)
	local opts = { noremap=true, silent=true, buffer=bufnr }
	map('n', 'gD', vim.lsp.buf.declaration, opts)
	map('n', 'gd', vim.lsp.buf.definition, opts)
	map('n', 'K', vim.lsp.buf.hover, opts)
	map('n', 'gi', vim.lsp.buf.implementation, opts)
	map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	map('n', '<leader>vrn', vim.lsp.buf.rename, opts)
	map('n', '<leader>vca', vim.lsp.buf.code_action, opts)
	map('n', '<leader>r', vim.lsp.buf.references, opts)
end

for server, cfg in pairs(enabled_servers) do
	if cfg then
		local user_conf = (type(cfg) == 'table') and cfg or {}
		if not user_conf.on_attach then
			user_conf.on_attach = def_on_attach
		end
		lsp_conf[server].setup(user_conf)
	end
end

