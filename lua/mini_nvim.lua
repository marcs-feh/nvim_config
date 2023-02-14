--- Mini.nvim setup ---

local theme = require 'colors'.mf
local link  = require 'utility'.hi_link_pairs
local hi    = require 'utility'.hi_overwrite_pairs

-- Extend motions a/i
require 'mini.ai'.setup()

-- Surround motions
require 'mini.surround'.setup()

-- Alignment motions
require 'mini.align'.setup()

-- Statusbar
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

-- Base16 colors
require 'mini.base16'.setup {
	palette = theme,
}

--- Overwrite some highlights for prettyness
hi {
	{'MiniStatuslineModeInsert', {bg = theme.base0A} },
	{'MiniStatuslineModeNormal', {bg = theme.base09} },
	{'MiniStatuslineModeVisual', {bg = theme.base0E} },
}

link {
	{'@repeat', 'Keyword'},
	{'@function.builtin', 'Function'},
}

