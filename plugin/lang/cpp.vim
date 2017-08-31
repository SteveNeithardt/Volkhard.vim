" vimrc for c code files

setlocal showmatch
setlocal cindent
setlocal smartindent
setlocal sidescroll=10
setlocal listchars+=precedes:<,extends:>
if has("folding")
	setlocal foldmethod=marker
endif

set filetype=cpp
