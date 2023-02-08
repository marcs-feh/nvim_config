-- Extend motions a/i
require 'mini.ai'.setup()

-- Surround motions
require 'mini.surround'.setup()

-- Alignment motions
require 'mini.align'.setup()

-- Comment motions
require 'mini.comment'.setup {
	mappings = {
		comment = '<leader>c',
		comment_line = '<leader>c',
	},
}

-- Statusbar
require 'mini.statusline'.setup()

-- Base16 colors
require 'mini.base16'.setup {
	palette = require 'colors'.gruvbox_dark,
}

-- Completion
require 'mini.completion'.setup()

