-- terminal aware buffer delete
function BDelete()
	if (vim.bo.buftype == 'terminal') then
		vim.cmd.bwipeout { bang = true }
	else
		vim.cmd.bdelete()
	end
end

-- buffer shortcuts
local opts = { noremap = true }
if (vim.fn.executable('fzf') ~= 1) then
	vim.keymap.set('n', '<Leader>b', ':buffer<Space>', opts)
end
vim.keymap.set('n', '<Leader>l', ':buffers<CR>', opts)
vim.keymap.set('n', '<Leader>d', BDelete, opts)
vim.keymap.set('n', '<Leader>n', ':bnext<CR>', opts)
vim.keymap.set('n', '<Leader>p', ':bprevious<CR>', opts)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)
