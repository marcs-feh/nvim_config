--- Treesitter ---
local ts_config = require 'nvim-treesitter.configs'

ts_config.setup {
	ensure_installed = {
		'c', 'lua', 'vim',
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

-- Personal recommendation for ensure_installed (popular languages + markup/config)
-- 'c', 'cpp', 'zig', 'rust', 'glsl', 'java', 'kotlin', 'c_sharp', 'go', 'swift', 'dart', 'scala', 'elixir', 'ocaml',
-- 'haskell', 'clojure', 'javascript', 'typescript', 'php', 'python', 'julia', 'ruby', 'perl', 'lua',
-- 'bash', 'scheme', 'vim', 'make', 'ninja', 'cmake', 'meson', 'nix', 'sql', 'markdown',
-- 'html', 'css', 'json', 'org', 'latex', 'ini', 'toml', 'yaml', 'gitignore', 'gitcommit', 'gomod', 'diff'
