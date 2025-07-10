-- buffer shortcuts
local opts = { noremap = true, buffer = true }
vim.keymap.set('n', '<Leader>ccd', 'O/// <summary></summary><CR><param name="param">desc</param><CR><returns>desc</returns><Esc>', opts)
vim.keymap.set('n', '<Leader>cd', 'Ado {<CR>} while (true);<Esc>', opts)
vim.keymap.set('n', '<Leader>ce', 'Aelse {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cei', 'Aelseif (true) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cf', 'Afor (int i = 0; i < vals.Count; i++) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cfe', 'Aforeach (var val in vals) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cfu', 'Apublic void FunctionName () {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>ci', 'Aif (true) {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cs', 'Aswitch (val) {<CR> case val:<CR>break;<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>ct', 'Atry {<CR>} catch (Exception e) {<CR>} finally {<CR>}<Esc>', opts)
vim.keymap.set('n', '<Leader>cw', 'Awhile (true) {<CR>}<Esc>', opts)
