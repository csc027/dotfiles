-- buffer shortcuts
local opts = { noremap = true, buffer = true }
vim.keymap.set('n', '<Leader>ccd', 'O<#<CR><CR>.SYNOPSIS<CR><CR>.DESCRIPTION<CR><CR>.PARAMETER parameter<CR><CR>.OUTPUTS<CR><CR>#><Esc>', opts)
vim.keymap.set('n', '<Leader>cd', 'Ado {<CR>} while ($true);<Esc>', opts)
vim.keymap.set('n', '<Leader>ce', 'Aelse {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cei', 'Aelseif ($true) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cf', 'Afor ($i = 0; $i -lt $Vals.Count; $i++) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cfe', 'Aforeach ($Val in $Vals) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cfu', 'Afunction FunctionName {<CR>param(<CR>)<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>ci', 'Aif ($true) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cs', 'Aswitch ($Val) {<CR>{ $_ } { $Result }<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>ct', 'Atry {<CR>} catch {<CR>} finally {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cw', 'Awhile ($true) {<CR>}<Esc>', opts)
