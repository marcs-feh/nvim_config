--- Base16 colors ---

local cols = {
	gruvbox = {
		base00 = '#1d2021', base01 = '#3c3836', base02 = '#504945', base03 = '#665c54',
		base04 = '#bdae93', base05 = '#d5c4a1', base06 = '#ebdbb2', base07 = '#fbf1c7',
		base08 = '#fb4934', base09 = '#fe8019', base0A = '#fabd2f', base0B = '#b8bb26',
		base0C = '#8ec07c', base0D = '#83a598', base0E = '#d3869b', base0F = '#d65d0e',
	},
	onedark = {
		base00 = '#282c34', base01 = '#353b45', base02 = '#3e4451', base03 = '#545862',
		base04 = '#565c64', base05 = '#abb2bf', base06 = '#b6bdca', base07 = '#c8ccd4',
		base08 = '#e06c75', base09 = '#d19a66', base0A = '#e5c07b', base0B = '#98c379',
		base0C = '#56b6c2', base0D = '#61afef', base0E = '#c678dd', base0F = '#be5046',
	},
	monokai = {
		base00 = '#272822', base01 = '#383830', base02 = '#49483e', base03 = '#75715e',
		base04 = '#a59f85', base05 = '#f8f8f2', base06 = '#f5f4f1', base07 = '#f9f8f5',
		base08 = '#f92672', base09 = '#fd971f', base0A = '#f4bf75', base0B = '#a6e22e',
		base0C = '#a1efe4', base0D = '#66d9ef', base0E = '#ae81ff', base0F = '#cc6633',
	},
	tokyo_night = {
		base00 = '#171D23', base01 = '#1D252C', base02 = '#28323A', base03 = '#526270',
		base04 = '#B7C5D3', base05 = '#D8E2EC', base06 = '#F6F6F8', base07 = '#FBFBFD',
		base08 = '#F7768E', base09 = '#FF9E64', base0A = '#B7C5D3', base0B = '#9ECE6A',
		base0C = '#89DDFF', base0D = '#7AA2F7', base0E = '#BB9AF7', base0F = '#BB9AF7',
	},
	catpuccin = {
		base00 = '#1E1E28', base01 = '#1A1826', base02 = '#302D41', base03 = '#575268',
		base04 = '#6E6C7C', base05 = '#D7DAE0', base06 = '#F5E0DC', base07 = '#C9CBFF',
		base08 = '#F28FAD', base09 = '#F8BD96', base0A = '#FAE3B0', base0B = '#ABE9B3',
		base0C = '#B5E8E0', base0D = '#96CDFB', base0E = '#DDB6F2', base0F = '#F2CDCD',
	},
	mf = {
		base00 = '#1d2021',
		base01 = '#303536',
		base02 = '#434a4c',
		base03 = '#606A6C',
		base04 = '#eed89f',
		base05 = '#f4e5bf',
		base06 = '#f9f1dc',
		base07 = '#fcf8ee',
		base08 = '#ebe3cb',
		base09 = '#c4dc9b',
		base0A = '#81aece',
		base0B = '#cd9169',
		base0C = '#f9f1dc',
		base0D = '#ecdc8b',
		base0E = '#cda2e3',
		base0F = '#f4e5bf',
	},
}

return cols

-- Base 16 Styling --
--[[
	base00 ---- Default Background
	base01 ---  Lighter Background (Used for status bars, line number and folding marks)
	base02 --   Selection Background
	base03 -    Comments, Invisibles, Line Highlighting
	base04 +    Dark Foreground (Used for status bars)
	base05 ++   Default Foreground, Caret, Delimiters, Operators
	base06 +++  Light Foreground (Not often used)
	base07 ++++ Light Background (Not often used)
	base08      Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
	base09      Integers, Boolean, Constants, XML Attributes, Markup Link Url
	base0A      Classes, Markup Bold, Search Text Background
	base0B      Strings, Inherited Class, Markup Code, Diff Inserted
	base0C      Support, Regular Expressions, Escape Characters, Markup Quotes
	base0D      Functions, Methods, Attribute IDs, Headings
	base0E      Keywords, Storage, Selector, Markup Italic, Diff Changed
	base0F      Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
--]]
