require('nvim-treesitter').setup(
	{
		install_dir = vim.fn.stdpath('data') .. '/site'
	}
)

require('nvim-treesitter').install(
	{
		'c_sharp',
		'diff',
		'json',
		'lua',
		'markdown',
		'markdown_inline',
		'powershell',
		'razor',
		'vim',
		'vimdoc'
	}
)
