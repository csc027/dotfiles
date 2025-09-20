require('buffer')
require('compare')
require('complete')
require('fzf')
require('general')
require('treesitter')
require('window')

-- ft/syntax settings
vim.cmd.syntax('on')
vim.cmd.filetype({ 'plugin', 'indent', 'on' })

-- color settings
require('colors')

-- statusline; dependent on the colorscheme being set first
require('statusline')
