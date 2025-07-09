-- completion shortcuts
local iopts = { noremap = true }
vim.keymap.set('i', '<C-f>', '<C-x><C-f>', iopts)
vim.keymap.set('i', '<C-k>', '<C-x><C-k>', iopts)
vim.keymap.set('i', '<C-l>', '<C-x><C-l>', iopts)
vim.keymap.set('i', '<C-o>', '<C-x><C-o>', iopts)

local nopts = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, nopts)
vim.keymap.set('n', '<Leader>sl', vim.diagnostic.setloclist, nopts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Disable lspconfig coloring for languages that have better native and/or treesitter coloring
	client.server_capabilities.semanticTokensProvider = nil

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', '<Leader>q', function() vim.lsp.buf.format { async = true } end, bufopts)
	vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<Leader>td', vim.lsp.buf.type_definition, bufopts)
end

vim.lsp.config['*'] = {
	on_attach = on_attach
}

vim.lsp.enable({ 'omnisharp', 'powershell_es' })
