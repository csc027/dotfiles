function! DiffToggle()
	if &diff
		windo set nodiff
	else
		windo set diff
	endif
endfunction

function! DiffToggleCaseSensitivity()
	if &diffopt =~ "icase"
		set diffopt-=icase
	else
		set diffopt+=icase
	endif
	diffupdate
endfunction

function! DiffToggleWhiteSpace()
	if &diffopt =~ "iwhiteall"
		set diffopt-=iwhiteall
	elseif &diffopt =~ "iwhite"
		set diffopt-=iwhite
	else
		set diffopt+=iwhiteall
	endif
	diffupdate
endfunction
