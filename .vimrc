execute pathogen#infect()

nnoremap j gj
nnoremap k gk

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

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
