" automatic, language-dependent indentation, syntax coloring
" and other functionality.
filetype indent plugin on
syntax on

" use utf-8
set encoding=utf-8

" tab size
set tabstop=4

" indentation size
set shiftwidth=4

" tabs/spaces interop
set softtabstop=4

" expand tabs to spaces
set expandtab

" show matching brackets
set showmatch

" enable autoindent
set autoindent

" set term var
set term=xterm-256color

" use jk as escape
inoremap jk <Esc>

" set default fold method
set foldmethod=indent

" set default fold level
set foldlevel=2