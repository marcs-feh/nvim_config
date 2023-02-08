local lsp_conf = require 'lspconfig'

-- Enable a server by providing a config table or using `true`
-- Disable by not providing its name or by setting it to `false`/`nil`
-- server_name = config | bool
local enabled_servers = {
	pyright = false,
	clangd  = nil,
}

for server, cfg in pairs(enabled_servers) do
	if cfg then
		lsp_conf[server].setup(type(cfg) == 'table' and cfg or {})
	end
end

