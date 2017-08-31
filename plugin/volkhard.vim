" Appearance and Utilities for my vim experience and enjoyment
"
" Stephen Neithardt, Switzerland


" ----------------------------------------------------------------------------

" Activates all Plugin Parts
function! Volkhard#ActivateAll() "{{{
	call Volkhard#ActivateOptions()
	call Volkhard#CustomLeader()
	call Volkhard#ActivateNavigationBindings()
	call Volkhard#ActivateLanguageCustomFunctionalities()
	call Volkhard#ActivateStatusLine()
	call Volkhard#ActivateFoldText()
	call Volkhard#ActivateColorscheme()
endfunction "}}}

" Plugin Parts ---------------------------------------------------------------

" Sets a number of default settings so vim is better
function! Volkhard#ActivateOptions() "{{{
	set encoding=utf-8
	set nobomb
	set vb
	set number
	set backspace=indent,eol,start
	set scrolloff=3
	set showcmd
	set virtualedit=all
	set history=99
	set splitright
	set incsearch
	set ignorecase
	set smartcase
	set wildmode=longest,list
	set tabstop=4
	set shiftwidth=4
	set noexpandtab
	set listchars+=tab:T-
	set listchars+=trail:*
	set winminheight=0
	set showbreak=>
	set linebreak
	if version >= 703
		set colorcolumn=80
		nnoremap <leader>r :set invrnu<CR>
	endif

endfunction "}}}

function! Volkhard#CustomLeader() "{{{
	let mapleader = '-'
endfunction "}}}

" Defines all navigation bindings, for splits and tabs
function! Volkhard#ActivateNavigationBindings() "{{{
	nnoremap <leader>tn :tabnew<CR>
	nnoremap <leader>tc :tabclose<CR>
	nnoremap <leader>tm :tabmove 
	nnoremap <leader>te :tabedit 
	nnoremap <leader>h :tabprevious<CR>
	nnoremap <leader>l :tabnext<CR>
	nnoremap <C-h> <C-w>h
	nnoremap <C-j> <C-w>j
	nnoremap <C-k> <C-w>k
	nnoremap <C-l> <C-w>l
	nnoremap <leader>w <C-w>_
	nnoremap <leader>dt :windo diffthis<CR>
	nnoremap <leader>do :windo diffoff<CR>
endfunction "}}}

" Defines (F5)F6 as (Un-)Commenting functions, depending on current language
" Defines other feature specific to developing within current language
"
" Current support:
" - bash.vim
" - cpp.vim
" - css.vim
" - js.vim
" - makefile.vim
" - php.vim
" - tex.vim
" - txt.vim
" - vim.vim
function! Volkhard#ActivateLanguageCustomFunctionalities() "{{{
	if has("autocmd")
		au BufRead,BufNewFile *.cpp,*.c,*.hpp,*.hpp,*.cu source lang/cpp.vim
		au BufRead,BufNewFile *.glsl source lang/cpp.vim
		au BufRead,BufNewFile *.tex,*.bib,*.sty source lang/tex.vim
		au BufRead,BufNewFile *.bash,*.sh source lang/bash.vim
		au BufRead,BufNewFile [Mm]akefile,*.mk,*.make source lang/makefile.vim
		au BufRead,BufNewFile *.m source lang/matlab.vim
		au BufRead,BufNewFile *.vim* source lang/vim.vim
		au BufRead,BufNewFile *.f source lang/fortran.vim
		au BufRead,BufNewFile *.txt source lang/txt.vim
		au BufRead,BufNewFile *.php source lang/php.vim
		au BufRead,BufNewFile *.js source lang/js.vim
		au BufRead,BufNewFile *.log source lang/log.vim
		au BufRead,BufNewFile *.py source lang/py.vim
		au BufRead,BufNewFile *.css,*.less source lang/css.vim
	endif
endfunction "}}}

" A better status line for better information
function! Volkhard#ActivateStatusLine() "{{{
	set ruler
	set laststatus=2
	set statusline=%!Volkhard#StatusLine()
endfunction "}}}

" A better fold text with extra info, and prettier display
function! Volkhard#ActivateFoldText() "{{{
	if has("folding")
		set foldenable
		set foldcolumn=3
		set foldtext=Volkhard#FoldText()
	endif " has("folding")
endfunction "}}}

" Make the colors as they should be
function! Volkhard#ActivateColorscheme() "{{{
	set background=dark

endfunction "}}}

" Helper functions -----------------------------------------------------------

" StatusLine
function! Volkhard#StatusLine() "{{{
	let l:buf = '%n '
	let l:file = '%<%F'
	let l:flags = ' %h%m%r'
	let l:middle = '%='
	let l:time = '%-22.(%{strftime("%a\ %d\ %b\ %H:%M")}%)'
	let l:linecolumn = '%-14.(%l,%c%V%)'
	let l:position = '%P'
	return l:buf . l:file . l:flags . l:middle . l:time . l:linecolumn . l:position
endfunction "}}}

" FoldText
function! Volkhard#FoldText() "{{{
	let l:winwidth = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
	let l:subline = getline(v:foldstart)
	let l:subchars = '%\|//\|/\*\|{{{\d*\|"\s'
	let l:subline = substitute(l:subline,l:subchars,'','g')
	let l:subline = substitute(l:subline,'^\s*','','')
	let l:interval = v:foldend - v:foldstart + 1
	let l:foldPercentage = printf("(%.1f",(l:interval*1.0)/line("$")*100)."%) "
	let l:interval = " ".l:interval." lines "
	let l:expandChars = repeat("-",max([l:winwidth/2-strlen(l:subline.l:interval),2]))
	let l:returnvalue0 = l:subline.l:expandChars.l:interval.l:foldPercentage
	let l:endChars = repeat("-",l:winwidth-strlen(l:returnvalue0)+1)
	let l:returnvalue = l:returnvalue0.l:endChars.v:foldlevel
	return l:returnvalue
endfunction "}}}
