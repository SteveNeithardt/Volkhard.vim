" vimrc for js code files

map <silent> <buffer> <F5> :s/^\(\(\t\)*\)/\1\/\//g<CR>
map <silent> <buffer> <F6> :s/^\(\(\t\)*\)\/\//\1/g<CR>

setlocal showmatch
setlocal smartindent

