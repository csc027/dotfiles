require('lualine').setup {
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { { 'filename', path = 3 } },
		lualine_c = { 'diagnostics' },
		lualine_x = { 'fileformat', 'encoding', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	options = {
		component_separators = '|',
		icons_enabled = false,
		section_separators = '',
		theme = 'ayu_dark'
	}
}
