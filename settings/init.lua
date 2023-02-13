require('buffer')
require('compare')
require('complete')
require('general')
require('netrw')
require('window')

-- ft/syntax settings
vim.cmd 'syntax on'
vim.cmd 'filetype plugin indent on'

-- color settings
vim.g.solarized_extra_groups = 1
vim.g.solarized_old_cursor_style = 1
vim.g.solarized_italics = 0
vim.g.lightline = { colorscheme = 'solarized', active = { left = { { 'mode', 'paste' }, { 'readonly', 'absolutepath', 'modified' } } } }
vim.cmd 'colorscheme solarized8_flat'

if vim.fn.has('termguicolors') then
	vim.opt.termguicolors = true
end
