set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/lightline.vim'
Plugin 'SirVer/ultisnips'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/neoinclude.vim'
Plugin 'honza/vim-snippets'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'dbakker/vim-lint'
Plugin 'wellle/targets.vim'
Plugin 'aperezdc/vim-template'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-scriptease'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-markdown'
Plugin 'coryknapp/vim-color-flash'
Plugin 'beyondmarc/glsl.vim'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'dhruvasagar/vim-markify'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'coryknapp/vim-underscoreproject'
Plugin 'keith/swift.vim'

" colors
Plugin 'jacoborus/tender'

"I suck at quitting vim properly, so this silences swap file exists messages
set shortmess+=A

"config vim-template to use my templates folder
let g:templates_directory = [ expand( "~/Code/dot-files/templates" ) ]

let g:syntastic_text_checkers = ['fucklint']

let g:neocomplete#enable_at_startup = 1

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'LightSkyBlue'],
    \ ['red',         'LightBlue'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

" some remappings		
let mapleader = "\<Space>"		
nnoremap <Leader>w :w<CR>		
nmap <Leader><Leader> V		
map <leader>k :Explore<cr> " open netrw explorer. 
vnoremap <silent> y y`]		
vnoremap <silent> p p`]		
nnoremap <silent> p p`] 
nnoremap <Leader>b <C-^>

nnoremap <Leader>p :CtrlP<CR>

nnoremap <C-/> //<CR> 

" remapping for git (fugitive)
nnoremap <Leader>gw :Gwrite<CR>		
nnoremap <Leader>gc :Gcommit<CR>		
nnoremap <Leader>gd :Gdiff<CR>		
nnoremap <Leader>gs :Gstatus<CR>	

" easier splitting
nnoremap <Leader>- :split<CR>
nnoremap <Leader>\ :vsplit<CR>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

colorscheme solarized

" fix stupid stuff about solarized
hi clear SignColumn

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

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'java', 'cpp', 'c', 'sql']

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

" fugitive config {{{
command! Gc :Gcommit
command! Gw :Gwrite
command! Gr :Gread
command! Gd :Gdiff
command! Gs :Gstatus

" turn on spell check for git commit messages 
autocmd BufNewFile,BufRead *COMMIT_EDITMSG setlocal spell spelllang=en_us
"}}}



" UltiSnips config and related hotkey {{{
" add my own code snippets to the path
let g:UltiSnipsSnippetDirectories=['UltiSnips',$HOME.'/Code/dot-files/snippets']

command! Snip exec "split ".join(
			\ [$HOME,'/Code/dot-files/snippets/',&filetype,'.snippets'], '' )

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<c-CR>"
let g:UltiSnipsJumpForwardTrigger = "<c-tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"}}}

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_vim_checkers = ['vint']
let g:syntastic_python_checkers = ['python', 'pylint', 'pep257']

let g:syntastic_error_symbol = 'X'
let g:syntastic_style_error_symbol = 'S'
let g:syntastic_warning_symbol = 'W'
let g:syntastic_style_warning_symbol = 's'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

"configure lightline [https://github.com/itchyny/lightline.vim] {{{
let g:lightline = {
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
      \ 'separator': { 'left': '|', 'right': '<'},
      \ 'subseparator': { 'left': '|', 'right': '<' }
      \ }

" }}}

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "✘"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "read only"
  else
    return ""
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


"change background color 80 chars in
"TODO make this work with solarized better
highlight ColorColumn ctermbg=235 guibg=#00222a
let &colorcolumn=join(range(81,999),",")

"java {{{
function! SetJavaOps ()
	" set up eclim
	
	let g:SuperTabDefaultCompletionType = 'context'
	
	" i like to run my java stuff in the apple terminal instead of in vim
	command! Ej call EclimRunInAppleTerminal()
	"set up syntastic
	let g:syntastic_java_checkers = ['javac']
	
	" turn on eclim syntax checking, because we use syntastic
	let g:EclimFileTypeValidate = 1

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

" LaTex {{{
function! SetLatexOps ()
	
	"typing &= is awkward
	imap <C-=> &=

	"set up word wrap
	set tw=79
	" call ToggleWordWrap()
	if &completefunc != '' | let &omnifunc=&completefunc | endif

	set makeprg=/Library/TeX/texbin/pdflatex\ %\ &&\ open\ %<.pdf 
	echo "Latex!"
endfunction
autocmd Filetype tex :call SetLatexOps ()

" }}}

" Python {{{
function! SetPythonOps ()
	syntax keyword pythonInclude self
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
	"make a new line right after the last #include and move there
	nnoremap <Leader>i :call MoveToAfterLastInclude()
	
	"transform a c++ member function prototype to a member function.
	let @t = "^d0$xa{0wi::hi"
	"cout this line after it's called
	nnoremap <leader>p ^v$yostd::cout << "<esc>pJi" << std::endl;<cr><esc>
	"cout this line before it's called
	nnoremap <leader>P ^v$yOstd::cout << "<esc>pJi" << std::endl;<cr><esc>

	nnoremap <Leader>a :call SwitchSourceHeader()<CR>
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
    find %:t:r.h
  else
    find %:t:r.cpp
  endif
endfunction


" }}}

" markdown{{{
function! SetMarkdownOps ()
	hi markdownLineBreak guibg='Dark Slate Blue' 
	hi markdownH2 guifg='Dark Cyan'
	hi markdownH3 guifg='Chartreuse'
	hi markdownH4 guifg='Pale Green'
	hi markdownH5 guifg='Purple'
	hi markdownH6 guifg='Light Blue'
endfunction

autocmd Filetype markdown call SetMarkdownOps()

" }}}
