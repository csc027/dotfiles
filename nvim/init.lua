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
require('ayu').setup({
	mirage = false,
	terminal = true,
	overrides = {
		Comment = { italic = false },
		LineNr = { fg = '#8F8D86' }
	}
})
require('ayu').colorscheme()

if vim.fn.has('termguicolors') then
	vim.opt.termguicolors = true
end
