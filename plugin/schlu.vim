if !has('python')
	finish
endif

let s:schlu_running = 0

let s:path = expand('<sfile>:p:h')

execute ("pyfile " . s:path . "/helloworld.py")

function! HeloWorld2()
	python get_char()
	echom "ggg" . s:ret
endfunc

function! s:SchluQuit()
	if s:schlu_running
		echo "Schu server quit"
	endif
	let s:schlu_running = 0
endfunction

let s:config = ["-u byte -d 3 " . expand('%'),
              \ "-u byte -d 3 *.cpp",
              \ "-u word -d 3 nytaarstalen_2015.txt"]

function! s:SchluComplete()
	if !s:schlu_running
		let s:schlu_running = 1
	endif
	return "d"
endfunction


function! s:PushIndent(count)
	let s:count = a:count
	let s:user_cindent = &l:cindent
	setl nocindent
	let s:user_autoindent = &l:autoindent
	setl noautoindent
	let s:user_smartindent = &l:smartindent
	setl nosmartindent
	let s:user_formatoptions = &l:formatoptions
	setl formatoptions=""
endfunction

function! s:PopIndent()
	if s:user_cindent
		setl cindent
	endif
	if s:user_autoindent
		setl autoindent
	endif
	if s:user_smartindent
		setl smartindent
	endif
	let &l:formatoptions = s:user_formatoptions
endfunction

nnoremap <silent> <F8> :<c-u>call <SID>PushIndent(v:count)<cr>i<c-r>=<SID>SchluComplete()<cr><c-\><c-o>:call <SID>PopIndent()<cr>
inoremap <silent> <F8> <c-\><c-o>:call <SID>PushIndent(0)<cr><c-r>=<SID>SchluComplete()<cr><c-\><c-o>:call <SID>PopIndent()<cr>
nnoremap <silent> <S-F8> :call <SID>SchluQuit()<cr>
inoremap <silent> <S-F8> <c-\><c-o>:call <SID>SchluQuit()<cr>
