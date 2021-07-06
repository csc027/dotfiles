" OmniSharp settings
let g:OmniSharp_popup_options = { 'highlight': 'Normal', 'padding': [1], 'border': [1] }

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview', 'popup'
" and 'popuphidden' if you don't want to see any documentation whatsoever.
" Note that neovim does not support `popuphidden` or `popup` yet:
" https://github.com/neovim/neovim/issues/10996
if has('patch-8.1.1880')
	set completeopt=longest,menuone,popuphidden
	set completepopup=highlight:Pmenu,border:off
else
	set completeopt=longest,menuone,preview
	set previewheight=5
endif

augroup omnisharp_commands
	autocmd!

	" Show type information automatically when the cursor stops moving.
	autocmd CursorHold *.cs OmniSharpTypeLookup

	" The following commands are contextual, based on the cursor position.
	autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
	autocmd FileType cs nmap <silent> <buffer> <Leader>fu <Plug>(omnisharp_find_usages)
	autocmd FileType cs nmap <silent> <buffer> <Leader>fi <Plug>(omnisharp_find_implementations)
	autocmd FileType cs nmap <silent> <buffer> <Leader>pd <Plug>(omnisharp_preview_definition)
	autocmd FileType cs nmap <silent> <buffer> <Leader>pi <Plug>(omnisharp_preview_implementations)
	autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
	autocmd FileType cs nmap <silent> <buffer> <Leader>fs <Plug>(omnisharp_find_symbol)
	autocmd FileType cs nmap <silent> <buffer> <Leader>fx <Plug>(omnisharp_fix_usings)
	autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
	autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

	" Navigate up and down by method/property/field
	autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
	autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)

	" Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
	autocmd FileType cs nmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)
	autocmd FileType cs xmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)

	autocmd FileType cs nmap <silent> <buffer> <Leader>q <Plug>(omnisharp_code_format)

	autocmd FileType cs nmap <silent> <buffer> <Leader>nm <Plug>(omnisharp_rename)
augroup END

