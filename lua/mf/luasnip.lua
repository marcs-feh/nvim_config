local ls = require 'luasnip'
local map = require 'mf.utils'.keymap

map({'i', 's'}, '<C-j>', function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end)

map({'i', 's'}, '<C-k>', function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end)

map({'i', 's'}, '<C-l>', function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

map({'i', 's'}, '<C-h>', function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end)

map('i', '<C-c>', function()
	if ls.expand_or_jumpable() then
		vim.cmd [[LuaSnipUnlinkCurrent]]
		print('Snippet cancelled')
	end
end)

ls.config.set_config {
	history = false,
	updateevents = 'TextChanged,TextChangedI',
	enable_autosnippets = false,
}

local s, i, t = ls.snippet, ls.insert_node, ls.text_node
local fmt = require 'luasnip.extras.fmt'.fmt
local rep = require 'luasnip.extras'.rep
local c = ls.choice_node
local f = ls.function_node

local cpp_cons_opts = function () return { t'{}', t';', t' = default;', t' = delete;'} end
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
	c = {
		s('type', fmt(
			[[
			typedef {} {} {};

			{} {} {{
			{}
			}};
			]], {c(1, {t'struct', t'enum', t'union'}),
			     i(2), rep(2), rep(1), rep(2), i(0)}
		)),
	},
	cpp = {
		s('copy', fmt(
			[[
			{}(const {}& {}){}

			{}& operator=(const {}& {}){}
			]],
			{
				i(1),
				rep(1), f(first_lower,{1}),
				c(2, cpp_cons_opts()),
				rep(1), rep(1), f(first_lower,{1}),
				c(3, cpp_cons_opts()),
			}
		)),
		s('move', fmt(
			[[
			{}({}&& {}){}

			{}& operator=({}&& {}){}
			]],
			{
				i(1),
				rep(1), f(first_lower,{1}),
				c(2, cpp_cons_opts()),

				rep(1), rep(1), f(first_lower,{1}),
				c(3, cpp_cons_opts())
			}
		)),
		s('cons', fmt(
			[[
			{}(){}

			~{}(){}
			]],
			{
				i(1),
				c(2, cpp_cons_opts()),
				rep(1), -- [[ Dtor ]]
				c(3, cpp_cons_opts()),
		})),
	}
})
