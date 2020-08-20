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
