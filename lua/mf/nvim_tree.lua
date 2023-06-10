require 'nvim-tree'.setup {
	disable_netrw = true,
	hijack_netrw = true,
	sync_root_with_cwd = false,
	view = {
		cursorline = true,
		width = 30,
	},
	renderer = {
		indent_width = 2,
		indent_markers = {
			enable = true,
		},
		icons = {
			webdev_colors = false,
			modified_placement = 'before',
			padding = ' ',
			symlink_arrow = ' → ',
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = false,
				modified = true,
			},
			glyphs = {
				default = '',
				symlink = '',
				bookmark = '',
				modified = '*',
				folder = {
					arrow_closed = '',
					arrow_open = '',
					default = '',
					open = '',
					empty = '',
					empty_open = '',
					symlink = '',
					symlink_open = '',
				},
			},
		},
	},
	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
			restrict_above_cwd = false,
		},
		expand_all = {
			max_folder_discovery = 128,
			exclude = {},
		},
	},
	live_filter = {
		prefix = '[FILTER]: ',
		always_show_folders = true,
	},
	ui = {
		confirm = {
			remove = true,
			trash = true,
		},
	},
}

