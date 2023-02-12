function DiffToggle()
	if (vim.wo.diff) then
		vim.cmd 'windo diffoff'
	else
		vim.cmd 'windo diffthis'
	end
end

function DiffToggleCaseSensitivity()
	if (string.match(vim.o.diffopt, 'icase')) then
		vim.opt.diffopt:remove { 'icase' }
	else
		vim.opt.diffopt:append { 'icase' }
	end
	vim.cmd 'diffupdate'
end

function DiffToggleWhiteSpace()
	if (string.match(vim.o.diffopt, 'iwhiteall')) then
		vim.opt.diffopt:remove { 'iwhiteall' }
	elseif (string.match(vim.o.diffopt, 'iwhite')) then
		vim.opt.diffopt:remove { 'iwhite' }
	else
		vim.opt.diffopt:append { 'iwhiteall' }
	end
	vim.cmd 'diffupdate'
end

-- diff shortcuts
local opts = { noremap = true }
vim.api.nvim_set_keymap('n', '<Leader>i', ':lua DiffToggleCaseSensitivity()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>w', ':lua DiffToggleWhiteSpace()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>s', ':lua DiffToggle()<CR>', opts)
