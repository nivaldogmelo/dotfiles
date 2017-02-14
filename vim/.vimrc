" Vim configuration File
" Author: Nivaldo Neto
" Created on: 12/02/2017
" Email: nivaldogmelo@gmail.com
" General Settings
syntax enable
set encoding=utf8		" Set encoding to utf-8
set number			" Show line number
set linebreak			" Breaks line at word
set showmatch			" Highlight matching brace

set hlsearch			" Highlight all search results
set incsearch                   " Highlight search while typing
set ignorecase			" Always ignore case-sensitive
set expandtab 			" Use spaces instead of tabs
set shiftwidth=4		" Number of auto-indent spaces
set smartindent			" Enable smart-indent
set softtabstop=4               " Number of spaces per Tab
set showcmd                     " Show commands entered in the file
set cul                         " Show current line

" Mapping Keys
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <F2> :w<cr>

" Enable Statusbar
set laststatus=2              

" --------------------------------------
" Set automatic expansion of parenthesis/brackets/etc"
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

" Starting NERDTree
autocmd vimenter * NERDTree 

" Autocomplete settings
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Enable mouse
set mouse=a

" Markdown Preview
let vim_markdown_preview_github=1

" Setting colorscheme
set termguicolors
colorscheme soft-theme
set background=dark

" Setting file icons
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
let g:airline_powerline_fonts = 1

" Configure Vundle
    set nocompatible

    " Vundle config
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    "i need this to install Vundle
    Plugin 'gmarik/Vundle.vim'

    " ---- Plugins ----
    Plugin 'vim-airline/vim-airline'
    Plugin 'tpope/vim-fugitive'
    Plugin 'scrooloose/nerdtree'
    Plugin 'ryanoasis/vim-devicons'
    Plugin 'vim-scripts/indentpython.vim'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'JamshedVesuna/vim-markdown-preview'
    
    " All of your Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required
