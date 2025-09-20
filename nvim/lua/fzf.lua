if (vim.fn.executable('fzf') == 1) then
	require('fzf-lua').setup(
		{
			winopts = {
				border = 'border-sharp',
				backdrop = 100,
				fullscreen = false,
				hidden = true,
				height = 0.6,
				preview = {
					border = 'border-sharp',
					delay = 50,
					layout = 'vertical',
					number = true,
					wrap = false,
					vertical = 'up:50%'
				},
				row = 1,
				scrollbar = 'float',
				scrolloff = -1,
				title_pos = 'center',
				width = 1.0
			}
		}
	)
	local opts = { noremap = true }
	vim.keymap.set('n', '<Leader>b', ':FzfLua buffers<CR>', opts)
	vim.keymap.set('n', '<Leader>f', ':FzfLua files<CR>', opts)
	vim.keymap.set('n', '<Leader>g', ':FzfLua git_files<CR>', opts)
end
