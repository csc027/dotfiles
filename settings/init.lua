-- split window shortcuts
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })

-- buffer shortcuts
vim.api.nvim_set_keymap('n', '<Leader>n', ':call NextBuffer()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>d', ':call DeleteBuffer()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>p', ':call PreviousBuffer()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>l', ':buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':buffer<Space>', { noremap = true })

-- completion shortcuts
vim.api.nvim_set_keymap('i', '<C-k>', '<C-x><C-k>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-o>', '<C-x><C-o>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-f>', '<C-x><C-f>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<C-x><C-l>', { noremap = true })
require('complete')

-- diff shortcuts
require('compare')
vim.api.nvim_set_keymap('n', '<Leader>i', ':lua DiffToggleCaseSensitivity()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>w', ':lua DiffToggleWhiteSpace()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>s', ':lua DiffToggle()<CR>', { noremap = true })

-- netrw shortcuts
vim.api.nvim_set_keymap('n', '<Leader>f', ':Lexplore<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>F', ':Lexplore!<CR>', { noremap = true })

-- other shortcuts
vim.api.nvim_set_keymap('n', '<Leader>r', ':set invrelativenumber<CR>', { noremap = true })

-- general settings
vim.opt.autoindent = true
vim.opt.background = 'dark'
vim.opt.colorcolumn = { '120', '180' }
vim.opt.completeopt = { 'longest', 'menuone' }
vim.opt.errorbells = false
vim.opt.foldenable = true
vim.opt.foldlevel = 2
vim.opt.foldmethod = 'indent'
vim.opt.foldnestmax = 1
vim.opt.hidden = true
vim.opt.history = 1000
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.lazyredraw = true
vim.opt.number = true
vim.opt.omnifunc = 'syntaxcomplete#Complete'
vim.opt.relativenumber = true
vim.opt.scrolloff = 1
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.sidescrolloff = 5
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.title = true
vim.opt.undolevels = 1000
vim.opt.visualbell = true

-- ft/syntax settings
vim.cmd 'syntax on'
vim.cmd 'filetype plugin indent on'

-- color settings
vim.g.solarized_extra_groups = 1
vim.g.solarized_old_cursor_style = 1
vim.g.solarized_italics = 0
vim.g.lightline = { colorscheme = 'solarized', active = { left = { { 'mode', 'paste' }, { 'readonly', 'absolutepath', 'modified' } } } }
vim.cmd 'colorscheme solarized8_flat'

-- terminal settings
if vim.fn.has('termguicolors') then
	vim.opt.termguicolors = true
end

-- netrw settings
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_bufsettings = 'nobuflisted nomodifiable nomodified nowrap number readonly relativenumber'
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -50
