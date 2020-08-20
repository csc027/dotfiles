function BufferAfter(buf)
	let buffers = getbufinfo({ 'buflisted' : 1 })->filter({_, val -> getbufvar(val.bufnr, '&buftype') != 'terminal' })->map({ _, val -> val.bufnr })
	let after = copy(buffers)->filter({ _, val -> val > a:buf })
	return after->get(0, buffers->get(0, a:buf))
endfunction

function BufferBefore(buf)
	let buffers = getbufinfo({ 'buflisted' : 1 })->filter({_, val -> getbufvar(val.bufnr, '&buftype') != 'terminal' })->map({ _, val -> val.bufnr })
	let before = copy(buffers)->filter({ _, val -> val < a:buf })
	return before->get(-1, buffers->get(-1, a:buf))
endfunction

function GetBufferNumber()
	if &filetype == 'netrw'
		return bufnr('%') - 1
	else
		return bufnr('%')
	endif
endfunction

function SwitchToBuffer(buf)
	silent execute ":buffer " . a:buf
endfunction

function PreviousBuffer()
	call SwitchToBuffer(BufferBefore(GetBufferNumber()))
endfunction

function NextBuffer()
	call SwitchToBuffer(BufferAfter(GetBufferNumber()))
endfunction

function DeleteBuffer()
	let buffernumber = GetBufferNumber()
	call SwitchToBuffer(BufferBefore(buffernumber))
	silent execute 'bdelete ' . buffernumber
endfunction
