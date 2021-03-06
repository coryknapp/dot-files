set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Git wrapper
Plugin 'tpope/vim-fugitive'
" vim-fugitive settings {{{
	" remapping for git (fugitive)
	nnoremap <Leader>gw :Gwrite<CR>		
	nnoremap <Leader>gc :Gcommit<CR>		
	nnoremap <Leader>gd :Gdiff<CR>		
	nnoremap <Leader>gs :Gstatus<CR>	
	" turn on spell check for git commit messages 
	autocmd BufNewFile,BufRead *COMMIT_EDITMSG setlocal spell spelllang=en_us
"}}}

" statusline enhancer
Plugin 'itchyny/lightline.vim'
" lightline.vim settings {{{
	let g:lightline = {
		  \ 'colorscheme': 'tender',
		  \ 'active': {
		  \   'left': [ [ 'mode', 'paste' ],
		  \             [ 'fugitive', 'filename' ] ]
		  \ },
		  \ 'component_function': {
		  \   'fugitive': 'MyFugitive',
		  \   'readonly': 'MyReadonly',
		  \   'modified': 'MyModified',
		  \   'filename': 'MyFilename'
		  \ },
		  \ }

	function! MyModified()
	  if &filetype ==? 'help'
		return ''
	  elseif &modified
		return '✘'
	  elseif &modifiable
		return ''
	  else
		return ''
	  endif
	endfunction

	function! MyReadonly()
	  if &filetype == 'help'
		return ''
	  elseif &readonly
		return 'read only'
	  else
		return ''
	  endif
	endfunction

	function! MyFugitive()
	  return exists('*fugitive#head') ? fugitive#head() : ''
	endfunction

	function! MyFilename()
	  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
		   \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
		   \ ('' != MyModified() ? ' ' . MyModified() : '')
	endfunction
" }}}

" Snippets
Plugin 'SirVer/ultisnips'
" ultisnips settings {{{
	" add my own code snippets to the path
	let g:UltiSnipsSnippetDirectories=['UltiSnips',$HOME.'/Code/dot-files/snippets']

	" edit the snippet file for the current type
	command! Snip exec "split ".join(
				\ [$HOME,'/Code/dot-files/snippets/',&filetype,'.snippets'], '' )

	" better key bindings for UltiSnipsExpandTrigger
	let g:UltiSnipsExpandTrigger = "<c-CR>"
	let g:UltiSnipsJumpForwardTrigger = "<c-tab>"
	let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }}}

" Useful snippets
Plugin 'honza/vim-snippets'

" Autocomplete
Plugin 'Shougo/deoplete.nvim'

" lint vimscript
Plugin 'dbakker/vim-lint'

" Vim plugin that provides additional text objects
Plugin 'wellle/targets.vim'

" templates
Plugin 'aperezdc/vim-template'
" vim-template' settings {{{
	" config vim-template to use my templates folder
	let g:templates_directory = [ expand( "~/Code/dot-files/templates" ) ]
" }}}

" Comment targets
Plugin 'tpope/vim-commentary'

" Tools for writing vimscript
Plugin 'tpope/vim-scriptease'

" Improved sessions
Plugin 'tpope/vim-obsession'

" Show color under cursor
Plugin 'coryknapp/vim-color-flash'

" Printing
Plugin 'coryknapp/vim-echo'

" Fuzzy file, buffer, mru, tag, etc finder.
Plugin 'ctrlpvim/ctrlp.vim'
" ctrlp settings {{{
	nnoremap <Leader>p :CtrlPMixed<CR>		

" }}}

" For swift language
Plugin 'keith/swift.vim'

" Check syntax in Vim asynchronously
Plugin 'w0rp/ale'

" Autocomplete for swift
Plugin 'mitsuse/autocomplete-swift'

Plugin 'mattn/emmet-vim'

" colors
Plugin 'jacoborus/tender'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

colorscheme tender

"I suck at quitting vim properly, so this silences swap file exists messages
set shortmess+=A


let g:neocomplete#enable_at_startup = 1

" some remappings		
let mapleader = "\<Space>"		
nnoremap <Leader>w :w<CR>		
nmap <Leader><Leader> V		
map <leader>k :Explore<cr> " open netrw explorer. 
vnoremap <silent> y y`]		
vnoremap <silent> p p`]		
nnoremap <silent> p p`] 
nnoremap <Leader>b <C-^> " go to last buffer 

nnoremap <C-/> //<CR> 
inoremap <C-Space> <esc>:CtrlPMixed<CR>

" easier splitting
nnoremap <Leader>- :split<CR>
nnoremap <Leader>\ :vsplit<CR>

" undo the auto inserted comments
inoremap <C-u> <esc> xxa

"swap values from around a comma
"from http://stackoverflow.com/questions/14727173/swap-items-in-comma-separated-list
nnoremap <silent> gl "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>
nnoremap <silent> gh "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

"turn spelling on by default
set spell spelllang=en_us

"move these to keep working directories clean
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

set nobackup
set nowritebackup

set shiftwidth=4
set tabstop=4
set smartindent
set background=dark 

set autoread

set number
set relativenumber

set laststatus=2

set cmdheight=1

setlocal spell spelllang=en_us

set foldmethod=marker

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'java', 'cpp', 'c', 'sql', 'cs']

"highlight weird chars. Sometimes they come from copying and pasting
syntax match weird_chars /\v[°]/
highlight weird_chars guibg='Dark Red'

"quickly edit vimrc {{{
"I keep a hard link to my vimrc at this path for git
command! Vrc edit $HOME/Code/dot-files/vimrc
command! Vso so $HOME/.vimrc
"}}}

command! Ob Obsess

" move up and down, regardless of the word wrap situation {{{
nmap j gj
nmap k gk
"}}}
"
" ease moving between splits/buffers {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"option-h on mac os x go to previous buffer
nnoremap ˙ :bp<CR>

"option-l on mac os x go to next buffer
nnoremap ¬ :bf<CR>
" }}}

"java {{{
function! SetJavaOps ()
	" set up eclim
	
	let g:SuperTabDefaultCompletionType = 'context'
	
	" i like to run my java stuff in the apple terminal instead of in vim
	command! Ej call EclimRunInAppleTerminal()
	
	" set error scanning and correcting
	imap <F12> :lnext<Enter>
	imap <F11> :lprev<Enter>
	imap <F10> :JavaCorrect<Enter>

endfunction
autocmd Filetype java call SetJavaOps()

function! EclimRunInAppleTerminal ()
	let projectName =  eclim#project#util#GetCurrentProjectName()
	silent execute "!osascript ~/Code/EclimRunJavaProjectInTerminal.scpt " . projectName 
endfunction 

" }}}

" LaTeX {{{
function! SetLatexOps ()
	
	"typing &= is awkward
	imap <C-=> &=

	"set up word wrap
	set tw=79
	" call ToggleWordWrap()
	if &completefunc != '' | let &omnifunc=&completefunc | endif
	nnoremap <leader>h1 ^i\section{<esc>$a}<esc>
	nnoremap <leader>h2 ^i\subsection{<esc>$a}<esc>
	nnoremap <leader>h3 ^i\subsection{<esc>$a}<esc>

	nnoremap <leader>o1 ^i\1 <esc>
	nnoremap <leader>o2 ^i<tab>\2 <esc>
	nnoremap <leader>o3 ^i<tab><tab>\3 <esc>

	"todo, protect the z buffer
	vnoremap <leader>sb "zdi\textbf{<esc>"zpa}<esc>

	set makeprg=/Library/TeX/texbin/pdflatex\ %\ &&\ open\ %<.pdf 

	syntax keyword OutlineLevel1 way
    syntax keyword OutlineLevel2 \\2
    syntax keyword OutlineLevel3 \\3
    syntax keyword OutlineLevel4 \\4
    syntax keyword OutlineLevel5 \\5
	
	hi OutlineLevel1 guifg='Dark Cyan'
	hi OutlineLevel2 guifg='Chartreuse'
	hi OutlineLevel3 guifg='Pale Green'
	hi OutlineLevel4 guifg='Purple'
	hi OutlineLevel5 guifg='Light Blue'

endfunction
autocmd Filetype tex :call SetLatexOps ()

" }}}

" Python {{{
function! SetPythonOps ()
	syntax keyword pythonInclude self
	let g:syntastic_python_checkers = ['flake8']
endfunction
autocmd Filetype py :call SetPythonOps()
" }}}

" c/c++{{{
function! SetCppOps ()
	let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
	" I like the io stuff to be very visible, because it's easy to forget to
	" take it out when after you're done testing/debugging
	syntax keyword cppPrintKeyword cout endl cin cerror
	hi def link cppPrintKeyword Todo
	syntax match bad_spacing /\v  +| *\t+ +| +\t+ */
	highlight bad_spacing guibg='Dark Slate Blue'
	"make a new line right after the last #include and move there
	nnoremap <Leader>i :call MoveToAfterLastInclude()
	
	"transform a c++ member function prototype to a member function.
	let @t = "^d0$xa{0wi::hi"

	nnoremap <Leader>a :call SwitchSourceHeader()<CR>

	syntax match member_vars /m_\w\+/
	hi member_vars	guifg=#9370DB

	syntax match member_constant_vars /c_\w\+/
	hi member_constant_vars	guifg=#7093DB

	syn region	cLamdaHeader	start=/\v\[.+\]\(/ end=/)/
	hi cLamdaHeader	guifg=#CC7799

	syn match	curly_bracket	/\v(\{|\})/
	hi curly_bracket	guifg=#06FA60

	syn region constructor_init_list
		\ start=/\v :\n/hs=e
		\ end=/\v\{/he=e-1
		\ contains=constructor_init_list_comment_b,constructor_init_list_comment_l

	syn region constructor_init_list_comment_b
		\ matchgroup=cCommentStart
		\ start="/\*" end="\*/"

	syn region	constructor_init_list_comment_l
		\ start="//"
		\ skip="\\$"
		\ end="$"

	hi constructor_init_list	guifg=#BABA60
	hi def link constructor_init_list_comment_b		Comment
	hi def link constructor_init_list_comment_l		Comment

endfunction
autocmd Filetype cpp :call SetCppOps()
autocmd Filetype h :call SetCppOps()
autocmd Filetype c :call SetCppOps()

function! MoveToAfterLastInclude ()
	execute "?#include"
	normal o
endfunction

function! SwitchSourceHeader ()
  if (expand ("%:e") == "cpp")
    find %:t:r.hpp
  else
    find %:t:r.cpp
  endif
endfunction


" }}}

" markdown{{{
function! SetMarkdownOps ()
	
	syntax match ftl_md_comment /\v\s*/////

	hi markdownLineBreak guibg='Dark Slate Blue' 
	hi markdownH2 guifg='Dark Cyan'
	hi markdownH3 guifg='Chartreuse'
	hi markdownH4 guifg='Pale Green'
	hi markdownH5 guifg='Purple'
	hi markdownH6 guifg='Light Blue'
endfunction

autocmd Filetype markdown call SetMarkdownOps()

" }}}

let g:closetag_filenames = "*.html,*.xhtml,*.xml"
