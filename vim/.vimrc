if v:progname == 'vi'
    set noloadplugins
endif

set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set number
set ruler

set splitright
set splitbelow

set hlsearch
set incsearch

set backspace=indent,eol,start

" Automatic, language-dependent indentation, syntax coloring and other
" functionality.
filetype indent plugin on
syntax on
