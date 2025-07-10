-- buffer shortcuts
local opts = { noremap = true, buffer = true }
vim.keymap.set('n', '<Leader>cd', '<Esc>Ado {<CR>} while ($true);<Esc>', opts)
vim.keymap.set('n', '<Leader>ce', '<Esc>Aelse {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cei', '<Esc>Aelseif ($true) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cf', '<Esc>Afor ($i = 0; $i -lt $Vals.Count; $i++) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cfe', '<Esc>Aforeach ($Val in $Vals) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cfu', '<Esc>Afunction FunctionName {<CR>param(<CR>)<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>ci', '<Esc>Aif ($true) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cs', '<Esc>Aswitch ($Val) {<CR>{ $_ } { $Result }<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>ct', '<Esc>Atry {<CR>} catch {<CR>} finally {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cw', '<Esc>Awhile ($true) {<CR>}<Esc>', opts)
