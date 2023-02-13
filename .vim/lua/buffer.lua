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
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)
vim.keymap.set('n', '<Leader>n', ':bnext<CR>', opts)
vim.keymap.set('n', '<Leader>d', ':lua BDelete()<CR>', opts)
vim.keymap.set('n', '<Leader>p', ':bprevious<CR>', opts)
vim.keymap.set('n', '<Leader>l', ':buffers<CR>', opts)
vim.keymap.set('n', '<Leader>b', ':buffer<Space>', opts)
