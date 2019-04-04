if !exists("g:potion_command")
	let g:potion_command = "bin/potion"
endif

function! PotionCompileAndRunFile()
	silent !clear
	execute "!" . g:potion_command . " " . bufname("%")
endfunction

function! PotionShowByteCode()
	let bytecode = system(g:potion_command . " -c -V " . bufname("%"))
	let buf = '__Potion_Bytecode__'
	let bufn = bufwinnr(buf)
	if bufn < 0
		vsplit __Potion_Bytecode__
	else
		execute bufn . "wincmd w"
	endif
	normal! ggdG
	setlocal filetype=potionbytecode
	setlocal buftype=nofile
	call append(0, split(bytecode,'\v\n'))
endfunction

nnoremap <buffer> <localleader>r :call PotionCompileAndRunFile()<cr>
nnoremap <buffer> <localleader>b :call PotionShowByteCode()<cr>
