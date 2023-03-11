--- Mini.nvim setup ---

-- Extend motions a/i
require 'mini.ai'.setup()

-- Surround motions
require 'mini.surround'.setup()

-- Alignment motions
require 'mini.align'.setup()

-- Statusline
require 'mini.statusline'.setup()

-- Tabline
require 'mini.tabline'.setup()

-- Completion
require 'mini.completion'.setup()

-- Comment motions
require 'mini.comment'.setup {
	mappings = {
		comment = '<leader>c',
		comment_line = '<leader>c',
	},
}

