-- netrw shortcuts
local opts = { noremap = true }
vim.api.nvim_set_keymap('n', '<Leader>f', ':Lexplore<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>F', ':Lexplore!<CR>', opts)

-- netrw settings
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_bufsettings = 'nobuflisted nomodifiable nomodified nowrap number readonly relativenumber'
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -50
