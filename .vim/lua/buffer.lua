-- terminal aware buffer delete
function BDelete()
	if (vim.bo.buftype == 'terminal') then
		vim.cmd 'bdelete!'
	else
		vim.cmd 'bdelete'
	end
end

-- buffer shortcuts
local opts = { noremap = true }
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', opts)
vim.api.nvim_set_keymap('n', '<Leader>n', ':bnext<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>d', ':lua BDelete()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>p', ':bprevious<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>l', ':buffers<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>b', ':buffer<Space>', opts)
