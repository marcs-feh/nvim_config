local hi = require 'mf.theme.hi'.hi_set_pairs
local c  = require 'mf.theme.colors'

hi {
	-- Core highlight groups
	{'Normal', { bg = c.bg, fg = c.fg }},
	{'Visual', { bg = c.bg_alt }},
	{'LineNr', { fg = c.bg_br }},
	{'SignColumn', { fg = c.fg_alt }},
	{'CursorLine', nil },
	{'CursorLineNr', { fg = c.bg_br_alt }},
	{'CursorLineSign', nil },
	{'MatchParen', { bg = c.bg_alt, fg = c.fg_br }},
	{'Pmenu', { bg = c.bg_alt, fg = c.fg_alt }},
	{'PmenuSel', { bg = c.fg_alt, fg = c.bg_alt, bold = true }},
	{'PmenuSBar', { bg = c.bg_br, fg = c.fg_br }},
	{'PmenuThumb', { bg = c.fg_br, fg = c.bg_br }},
	-- Syntax
	{'String', { fg = c.str }},
	{'Comment', { fg = c.bg_br_alt }},
	{'Special', nil },
	{'Operator', nil },
	{'Identifier', { fg = c.id }},
	{'Constant', { fg = c.id_alt }},
	{'Boolean', { fg = c.literal_alt }},
	{'Keyword', { fg = c.reserved }},
	{'Repeat', { fg = c.reserved }},
	{'Number', { fg = c.literal }},
	{'Function', { fg = c.func }},
	-- Treesitter specific
	{'@constant.builtin', { fg = c.literal_alt }},
}
