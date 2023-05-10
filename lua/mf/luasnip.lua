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

local s, i, t = ls.snippet, ls.insert_node, ls.text_node
local snip = require 'luasnip'
local fmt = require 'luasnip.extras.fmt'.fmt
local rep = require 'luasnip.extras'.rep
local c = ls.choice_node
local f = ls.function_node


local first_lower = function(args) return args[1][1]:sub(1,1):lower() end
ls.add_snippets(nil, {
	all = {
		s('date', { c(1, {
			f(function() return os.date('%Y-%m-%d') end),
			f(function() return os.date('%Y-%m-%d %H:%M') end),
			f(function() return os.date('%H:%M') end),
			f(function() return os.date('%b %d(%a) %Y') end),
			})}),
	},
	cpp = {
		s('cons', fmt(
			[[
			{}(){{
				// TODO: impl.
			}}
			{}(const {}& {}){{
				// TODO: impl.
			}}
			{}({}&& {}){{
				// TODO: impl.
			}}
			~{}(){{
				// TODO: impl.
			}}
			]],
			-- TODO: choice for init
			{
				i(1),--[[ Name ]]
				rep(1), rep(1), --[[ Copy ctor ]]
				f(first_lower,{1}),
				rep(1), rep(1), --[[ Move ctor ]]
				f(first_lower,{1}),
				rep(1), -- [[ Dtor ]]
		}))
	}
})
