" Enable Syntax 
if has("syntax")
  syntax on
endif

" Default settings
set nu
set ai
set ruler
set cul
set bs=eol,start,indent
set showmatch
set smartcase
set smarttab
set expandtab
set smartindent
set incsearch
set hlsearch
set nocompatible 
set nobackup
filetype plugin indent on

" Parameter settings
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\
set sw=4
set ts=4
set sts=4
set history=1000
set fileencodings=utf-8

" Set cursor to last modified
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

" Set Vundle
set rtp+=~/.vim/bundle/Vundle.vim 
call vundle#begin() 
Plugin 'gmarik/Vundle.vim' "required
Plugin 'tpope/vim-fugitive' "required

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'

Plugin 'Raimondi/delimitMate'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

"Plugin 'Valloric/YouCompleteMe'

Plugin 'joshdick/onedark.vim'  " One Dark theme

call vundle#end()            
filetype plugin indent on " Put your non-Plugin stuff after this line

" Plugin Settings
let delimitMate_expand_cr=1

" The-NERD-Tree
autocmd BufEnter * lcd %:p:h
autocmd VimEnter * if !argc() | NERDTree | endif
nmap <leader>ne :NERDTreeToggle<cr>
let NERDTreeShowLineNumbers=1
let g:NERDTreeWinPos = "left"
map <F3> :NERDTreeToggle<cr>

" for vim-airline
let g:airline#extensions#tabline#enabled = 1 " turn on buffer list
let g:airline_theme='hybrid'
set laststatus=2 " turn on bottom bar

" NERD Commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" customize keymapping
map <Leader>cc <plug>NERDComToggleComment
map <Leader>c<space> <plug>NERDComComment

syntax enable
set background=dark
colorscheme onedark