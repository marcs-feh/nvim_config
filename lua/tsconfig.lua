--- Treesitter
local ts_config = require 'nvim-treesitter.configs'

ts_config.setup {
	ensure_installed = { 'c', 'lua', 'vim' },
	ignore_install = {'phpdoc', 'v'},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true,
	},
}

-- Personal recommendation for ensure_installed (popular languages)
--	'c', 'cpp', 'rust', 'java', 'c_sharp', 'go', 'swift', 'dart',
--	'scala', 'elixir', 'haskell', 'javascript', 'typescript', 'php',
--	'python','ruby', 'perl', 'lua', 'bash', 'powershell', 'scheme',
--	'vim', 'make', 'ninja', 'nix', 'sql', 'markdown', 'html', 'css',
--	'json',
