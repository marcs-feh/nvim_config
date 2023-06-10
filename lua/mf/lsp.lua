--- LSP configuration ---

-- Enable a server by providing a config table or using `true`
-- Disable by not providing its name or by setting it to `false`/`nil`
-- server_name = config | bool (use default config)
local enabled_servers = {
	-- Python
	pyright = true,
	-- Odin
	ols = true,
	-- Go
	gopls = true,
	-- Zig
	zls = nil,
	-- HTML Snippets
	emmet_ls = true,
	-- Bash
	bashls = true,
	-- Rust
	rust_analyzer = true,
	-- Svelte
	svelte = true,
	-- C/C++
	clangd = {
		cmd = {'clangd', '-header-insertion=never'}
	},
	-- Lua
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = { globals = {'vim'}, },
				telemetry = { enable = false },
			},
		}
	},
}

local lsp_conf = require 'lspconfig'
local map = require 'mf.utils'.keymap

-- Default on_attach function, sets keybindings
local def_on_attach = function(_, bufnr)
	local opts = { noremap=true, silent=true, buffer=bufnr }
	map('n', 'gD', vim.lsp.buf.declaration, opts)
	map('n', 'gd', vim.lsp.buf.definition, opts)
	map('n', 'K', vim.lsp.buf.hover, opts)
	map('n', 'gi', vim.lsp.buf.implementation, opts)
	map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	map('n', '<leader>vrn', vim.lsp.buf.rename, opts)
	map('n', '<leader>vca', vim.lsp.buf.code_action, opts)
	map('n', '<leader>r', vim.lsp.buf.references, opts)
	map('n', '<leader>D', ':Telescope diagnostics<CR>')
	map('n', '<leader>vS', ':LspStop<CR>')
	map('n', '<leader>vR', ':LspRestart<CR>')
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

