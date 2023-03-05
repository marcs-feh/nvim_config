--- Treesitter ---
local ts_config = require 'nvim-treesitter.configs'

ts_config.setup {
	ensure_installed = {
		-- General purpose (Systems programming)
		'c', 'cpp', 'zig', 'rust',
		-- General purpose (Memory managed)
		'java', 'kotlin', 'c_sharp', 'go', 'swift', 'dart','python', 'ruby',
		-- General purpose (Functional)
		'scala', 'erlang', 'elixir', 'ocaml', 'haskell', 'clojure', 'nix',
		-- Web dev
		'javascript', 'typescript', 'php',
		-- Graphics and GPU accel.
		'glsl', 'cuda',
		-- Scripting
		'lua', 'scheme', 'vim', 'fish', 'bash', 'perl',
		-- Build systems
		'make', 'ninja', 'cmake', 'meson',
		-- Markup and configuration
		'html', 'css', 'json', 'org', 'latex', 'ini', 'toml', 'yaml', 'markdown', 'dockerfile',
		-- Other
		'gitignore', 'gitcommit', 'diff', 'sql', 'awk', 'graphql', 'verilog',
	},
	ignore_install = {'phpdoc', 'javadoc', 'v'},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true,
	},
}

