" functions
function! PreviousBuffer()
	bprev
	if &buftype == 'terminal'
		bprev
	endif
endfunction

function! NextBuffer()
	bnext
	if &buftype == 'terminal'
		bnext
	endif
endfunction

function! EnableCoc()
	if executable("node") && executable("npm")
		packadd coc.nvim
	endif
endfunction

" completion
inoremap <C-k> <C-x><C-k>
inoremap <C-o> <C-x><C-o>
inoremap <C-f> <C-x><C-f>
inoremap <C-l> <C-x><C-l>

" split window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" buffer shortcuts
nnoremap <Leader>n :call NextBuffer()<CR>
nnoremap <Leader>d :bdelete<CR>
nnoremap <Leader>p :call PreviousBuffer()<CR>
nnoremap <Leader>l :buffers<CR>
nnoremap <Leader>b :buffers<CR>:b

" toggle relative number
nnoremap <Leader>r :set invrelativenumber<CR>

" completion
nnoremap <Leader>c :call EnableCoc()<CR>

set autoindent
set backspace=2
set background=dark
set foldlevel=2
set foldmethod=indent
set foldnestmax=1
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set noerrorbells
set nofoldenable
set noshowmode
set number
set omnifunc=syntaxcomplete#Complete
set relativenumber
set scrolloff=1
set sidescrolloff=5
set smartcase
set smarttab
set shiftround
set shiftwidth=4
set synmaxcol=300
set tabstop=4
set title
set undolevels=1000
set visualbell

syntax on
filetype plugin indent on

let g:solarized_extra_groups = 1
let g:solarized_old_cursor_style = 1
let g:solarized_italics = 0
let g:lightline = { 'colorscheme': 'solarized', 'active': { 'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ] } }

if has("termguicolors")
	set termguicolors
endif

colorscheme solarized8_flat

set completeopt=longest,menuone

if has("gui_running")
	autocmd GUIENTER * simalt ~x
	set guifont=Lucida\ Console:h10:cANSI
	set guioptions-=m
	set guioptions-=T
	set guioptions-=r
endif
