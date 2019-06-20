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
set shiftwidth=2	" Number of auto-ident spaces
set smartindent		" Enable smart-ident
set softtabstop=2	" Number of spaces per tab
set showcmd		" Show commands entered in the file
set cul			" Show current line
set textwidth=80        " For the cursor onto a new line after 80 characters
"set colorcolumn=+1      " Show when you're approaching 80 char

" Colorcolumn style
"highlight ColorColumn ctermbg=DarkGreen
"let &colorcolumn=join(range(81,999),",")

" Enable syntax highlight
syntax on

" Confs for git
autocmd FileType gitcommit set textwidth=72

" Enable mouse
set mouse=a

" Mapping Keys
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <F2> :w<cr>
nmap oo o<Esc>k

" Enable Statusbar
set laststatus=2

" Setting folding
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf
set foldmethod:marker
set foldmarker={,}
set foldlevelstart=99
set foldlevel=99
highlight Folded ctermbg=Black ctermfg=Green



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

" Status bar
Plugin 'vim-airline/vim-airline'

" Wakatime
Plugin 'wakatime/vim-wakatime'

" All plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" Yaml file handling
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
filetype plugin indent on
autocmd FileType yaml setl indentkeys-=<:>"
au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead Jenkinsfile-test setf groovy
au BufNewFile,BufRead Jenkinsfile-staging setf groovy
au BufNewFile,BufRead Jenkinsfile-default setf groovy
