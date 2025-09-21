if (vim.fn.executable('fzf') == 1) then
	require('fzf-lua').setup(
		{
			actions = {
				buffers = {
					["ctrl-x"] = { fn = FzfLua.actions.buf_del, reload = true },
					["enter"]  = FzfLua.actions.file_edit
				},
				files = {
					["enter"]  = FzfLua.actions.file_edit
				},
				git_files = {
					["enter"]  = FzfLua.actions.file_edit
				}
			},
			buffers = {
				prompt             = 'Buffers❯ ',
				file_icons         = false,
				color_icons        = false,
				sort_lastused      = false,
				show_unloaded      = true,
				cwd_only           = false,
				cwd                = nil
			},
			files = {
				prompt             = 'Files❯ ',
				multiprocess       = true,
				git_icons          = false,
				file_icons         = false,
				color_icons        = false,
				find_opts          = [[-type f \! -path '*/.git/*']],
				rg_opts            = [[--hidden --files -g "!.git"]],
				fd_opts            = [[--hidden --type f --type l --exclude .git]],
				dir_opts           = [[/s/b/a:-d]],
				cwd_prompt         = false,
				toggle_ignore_flag = "--no-ignore",
				toggle_hidden_flag = "--hidden",
				toggle_follow_flag = "-L",
				hidden             = true,
				follow             = false,
				no_ignore          = false
			},
			git = {
				files = {
					prompt        = 'Git Files❯ ',
					cmd           = 'git ls-files --exclude-standard',
					multiprocess  = true,
					git_icons     = false,
					file_icons    = false,
					color_icons   = false
				},
			},
			fzf_opts = {
				['--layout'] = 'default',
				['--multi'] = true
			},
			fzf_colors = {
				true,
				['bg']          = { 'bg', 'Normal' },
				['bg+']         = { 'bg', 'Comment' },
				['fg']          = { 'fg', 'CursorLine' },
				['fg+']         = { 'fg', 'Normal' },
				['gutter']      = -1,
				['hl']          = { 'fg', 'Comment' },
				['hl+']         = { 'fg', 'Statement' },
				['info']        = { 'fg', 'PreProc' },
				['marker']      = { 'fg', 'Keyword' },
				['pointer']     = { 'fg', '#9b0f1b', 'bold' },
				['prompt']      = { 'fg', 'Normal' },
				['spinner']     = { 'fg', 'Label' }
			},
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
	vim.keymap.set('n', '<Leader>b', FzfLua.buffers, opts)
	vim.keymap.set('n', '<Leader>f', FzfLua.files, opts)
	vim.keymap.set('n', '<Leader>g', FzfLua.git_files, opts)
	vim.keymap.set('n', '<Leader>rg', FzfLua.live_grep_native, opts)
end
