source ~/.common.vimrc

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

" diff shortcuts
nnoremap <Leader>i :call DiffToggleCaseSensitivity()<CR>
nnoremap <Leader>w :call DiffToggleWhiteSpace()<CR>
nnoremap <Leader>s :call DiffToggle()<CR>

" netrw shortcuts
nnoremap <Leader>f :Lexplore<CR>

" general settings
set background=dark
set colorcolumn=120,180
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

" netrw settings
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_bufsettings = 'nobuflisted nomodifiable nomodified nowrap number readonly relativenumber'
let g:netrw_liststyle = 3
let g:netrw_winsize = -50

colorscheme solarized8_flat
