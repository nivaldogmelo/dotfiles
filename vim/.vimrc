" Vim configurarion file
" Author: Nivaldo Neto
" Created on: 12/02/2017
" Email: nivaldogmelo@gmail.com

" General Settings
set encoding=utf8	" Set encoding to utf-8
set number		" Show line number
set linebreak		" Breaks line at word
set showmatch		" Highlight matching brace
set hlsearch		" Highlight all search results
set incsearch		" Highlight search whyle typing
set ignorecase		" Always ignore case-sensitive
set expandtab		" Use spaces instead of tabs
set shiftwidth=4	" Number of auto-ident spaces
set smartindent		" Enable smart-ident
set softtabstop=4	" Number of spaces per tab
set showcmd		" Show commands entered in the file
set cul			" Show current line

" Enable syntax highlight
syntax on

" Enable mouse
set mouse=a

" Mapping Keys
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <F2> :w<cr>

" Enable Statusbar
set laststatus=2

" Set automatic expansion of parenthesis/brackets/etc
ino " ""<left>
ino ' ''<left>
ino ( ()<left>
ino [ []<left>
ino { {}<left>

" Open file on the last edition
autocmd BufReadPost *
\   if line("'\"") > 0 && line("'\"") <= line("$") |
\       exe "normal g`\"" |
\   endif

" Save cursor position
augroup resCur
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" Required by Vundle
set nocompatible
filetype off

" Set runtime path to Vundle and initializa
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Autocomplete
Plugin 'Valloric/YouCompleteMe'

" Syntax checker
Plugin 'scrooloose/syntastic'

" Status bar
Plugin 'vim-airline/vim-airline'

" Git Wrapper
Plugin 'tpope/vim-fugitive'

" Wakatime
Plugin 'wakatime/vim-wakatime'

" All plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" Set python2 server for YCM
let g:ycm_server_python_interpreter = '/usr/bin/python2'
" Do not display Scratch window
set completeopt-=preview

" Syntastic Confs
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Yaml file handling
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
filetype plugin indent on
autocmd FileType yaml setl indentkeys-=<:>"
au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead Jenkinsfile-test setf groovy
au BufNewFile,BufRead Jenkinsfile-staging setf groovy
