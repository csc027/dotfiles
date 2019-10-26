execute pathogen#infect()

" wrapped lines
nnoremap j gj
nnoremap k gk

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

set autoindent
set backspace=2
set background=dark
set foldlevel=2
set foldmethod=syntax
set foldnestmax=1
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set noerrorbells
set nofoldenable
set noshowmode
set number
set omnifunc=syntaxcomplete#Complete
set scrolloff=1
set sidescrolloff=5
set smartcase
set smarttab
set shiftround
set shiftwidth=4
set tabstop=4
set title
set undolevels=1000
set visualbell

syntax on
filetype plugin indent on

let g:solarized_italic = 0
let g:lightline = { "colorscheme" : "solarized" }

colorscheme solarized

highlight Pmenu ctermbg=215 gui=bold

set completeopt=longest,menuone

" custom commands begin

let posh = ["ps1", "psm1", "psd1"]
if index(posh, expand("%:e")) >= 0
	set dictionary+=$HOME/dotfiles/.vim/poshdict.txt
endif

" custom commands end

if has("gui_running")
	au GUIENTER * simalt ~x
	set guifont=Lucida\ Console:h10:cANSI
	set guioptions-=m
	set guioptions-=T
	set guioptions-=r
endif
