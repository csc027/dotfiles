require('buffer')
require('compare')
require('complete')
require('general')
require('netrw')
require('statusline')
require('treesitter')
require('window')

-- ft/syntax settings
vim.cmd.syntax('on')
vim.cmd.filetype({ 'plugin', 'indent', 'on' })

-- color settings
vim.g.solarized_italics = 0
vim.cmd.colorscheme('solarized')

if vim.fn.has('termguicolors') then
	vim.opt.termguicolors = true
end
