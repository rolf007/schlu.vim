if !has('python')
	finish
endif

let s:path = expand('<sfile>:p:h')

execute ("pyfile " . s:path . "/helloworld.py")

function! HeloWorld2()
	python get_char()
	echom "ggg" . s:ret
endfunc
