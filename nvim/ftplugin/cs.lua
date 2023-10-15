-- buffer shortcuts
local opts = { noremap = true }
vim.keymap.set('n', '<Leader>cd', '<Esc>Ado {<CR>} while (true);<Esc>', opts)
vim.keymap.set('n', '<Leader>ce', '<Esc>Aelse {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cei', '<Esc>Aelseif (true) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cf', '<Esc>Afor (int i = 0; i < vals.Count; i++) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cfe', '<Esc>Aforeach (var val in vals) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cfu', '<Esc>Apublic void FunctionName () {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>ci', '<Esc>Aif (true) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cs', '<Esc>Aswitch (val) {<CR> case val:<CR>break;<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>ct', '<Esc>Atry {<CR>} catch (Exception e) {<CR>} finally {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cw', '<Esc>Awhile (true) {<CR>}<Esc>', opts)
