set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/syntastic'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-obsession'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'coryknapp/vim-echo'

" colors
Plugin 'zanglg/nova.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set termguicolors
colorscheme nova

" some remappings		
let mapleader = "\<Space>"		
nnoremap <Leader>w :w<CR>		
nmap <Leader><Leader> V		
vnoremap <silent> y y`]		
vnoremap <silent> p p`]		
nnoremap <silent> p p`] 
nnoremap <Leader>b <C-^> " go to last buffer 

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
"syntastic settings {{{
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_python_checkers = ['python', 'pylint', 'pep257']

let g:syntastic_error_symbol = 'X'
let g:syntastic_style_error_symbol = 'S'
let g:syntastic_warning_symbol = 'W'
let g:syntastic_style_warning_symbol = 's'

highlight link SyntasticErrorSign Error
highlight link SyntasticWarningSign Todo
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn
"}}}

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

"change background color 80 chars in
"TODO make this work with solarized better
highlight ColorColumn ctermbg=235 guibg=#00222a
let &colorcolumn=join(range(81,999),',')

" Python {{{
function! SetPythonOps ()
	syntax keyword pythonInclude self
endfunction
autocmd Filetype py :call SetPythonOps()
" }}}

