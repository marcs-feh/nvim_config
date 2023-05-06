local ls = require 'luasnip'
local map = require 'mf.utils'.keymap

map({'i', 's'}, '<C-k>', function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end)

map({'i', 's'}, '<C-j>', function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end)

map({'i', 's'}, '<C-l>', function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

ls.config.set_config {
	history = false,
	updateevents = 'TextChanged,TextChangedI',
	enable_autosnippets = false,
}

-- local s, i, t = ls.s, ls.insert_node, ls.text_node
-- local fmt = require 'luasnip.extras.fmt'.fmt
-- local c = ls.choice_node
-- local f = ls.function_node
--
-- local date = function() return os.date('%Y-%m-%d %H:%M') end
--
-- ls.add_snippets(nil, {
-- 	all = {
-- 		s('date', { f(date) }),
-- 	},
-- 	cpp = {
-- 		s('ctor', fmt(
-- 			[[
-- 			{}(){{
-- 				// TODO: Constructor
-- 			}}
-- 			]], {i(1)}))
-- 	}
-- })
