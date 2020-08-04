source ~/.common.vimrc

" functions
function! BufferAfter(buf)
	let buffers = getbufinfo({ 'buflisted' : 1 })->filter({_, val -> getbufvar(val.bufnr, '&buftype') != 'terminal' })->map({ _, val -> val.bufnr })
	let after = copy(buffers)->filter({ _, val -> val > a:buf })
	return after->get(0, buffers->get(0, a:buf))
endfunction

function! BufferBefore(buf)
	let buffers = getbufinfo({ 'buflisted' : 1 })->filter({_, val -> getbufvar(val.bufnr, '&buftype') != 'terminal' })->map({ _, val -> val.bufnr })
	let before = copy(buffers)->filter({ _, val -> val < a:buf })
	return before->get(-1, buffers->get(-1, a:buf))
endfunction

function! PreviousBuffer()
	silent execute ":buffer " . BufferBefore(bufnr('%'))
endfunction

function! NextBuffer()
	silent execute ":buffer " . BufferAfter(bufnr('%'))
endfunction

function! DeleteBuffer()
	bdelete
	if &buftype == 'terminal'
		call PreviousBuffer()
	endif
endfunction

function! EnableCoc()
	if executable("node") && executable("npm")
		packadd coc.nvim
	endif
endfunction

" split window shortcuts
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" buffer shortcuts
nnoremap <Leader>n :call NextBuffer()<CR>
nnoremap <Leader>d :call DeleteBuffer()<CR>
nnoremap <Leader>p :call PreviousBuffer()<CR>
nnoremap <Leader>l :buffers<CR>
nnoremap <Leader>b :buffer<Space>

" completion shortcuts
inoremap <C-k> <C-x><C-k>
inoremap <C-o> <C-x><C-o>
inoremap <C-f> <C-x><C-f>
inoremap <C-l> <C-x><C-l>
nnoremap <Leader>c :call EnableCoc()<CR>

" general settings
set background=dark
set completeopt=longest,menuone
set foldlevel=2
set foldmethod=indent
set foldnestmax=1
set hidden
set laststatus=2
set lazyredraw
set noerrorbells
set nofoldenable
set noshowmode
set omnifunc=syntaxcomplete#Complete
set sidescrolloff=5
set smarttab
set shiftround
set title
set undolevels=1000

" ft/syntax settings
syntax on
filetype plugin indent on

" color settings
let g:solarized_extra_groups = 1
let g:solarized_old_cursor_style = 1
let g:solarized_italics = 0
let g:lightline = { 'colorscheme': 'solarized', 'active': { 'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ] } }

if has("termguicolors")
	set termguicolors
endif

colorscheme solarized8_flat

" gvim settings
if has("gui_running")
	autocmd GUIENTER * simalt ~x
	set guifont=Lucida\ Console:h10:cANSI
	set guioptions-=m
	set guioptions-=T
	set guioptions-=r
endif
