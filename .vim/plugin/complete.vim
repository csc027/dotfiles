function! EnableCoc()
	if executable("node") && executable("npm")
		packadd coc.nvim
	endif
endfunction
