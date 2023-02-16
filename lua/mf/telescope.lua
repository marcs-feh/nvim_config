
local map = require 'mf.utils'.keymap
local tel = require 'telescope.builtin'

map('n', '<leader>e', tel.find_files )
map('n', '<C-f>', tel.live_grep )
