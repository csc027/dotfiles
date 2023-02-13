-- function to toggle absolute numbers quickly
function InvertRelativeNumber()
	vim.wo.relativenumber = not vim.wo.relativenumber
end

-- split window shortcuts
local opts = { noremap = true }
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)
vim.keymap.set('n', '<Leader>r', ':lua InvertRelativeNumber()<CR>', opts)
