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

" persistent undo
set undofile
set undodir=~/.cache/vim/undo

set backspace=indent,eol,start

set laststatus=2

set exrc
set secure

" show longest match like bash completion, list candidates
set wildmode=full:longest:list

" override highlighting
" great gist by romainl: https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f#file-colorscheme-override-md
augroup myhighlight
    autocmd!

    " Replace Visual highlight with uniform, simple colors
    " Replace Folded highlight with comment highlight
    autocmd ColorScheme * hi! Visual ctermfg=0 ctermbg=4 guifg=Black guibg=Blue
                      \ | hi! link Folded Comment
                      \ | hi! link SignColumn LineNr
augroup END

colorscheme default
set bg=dark

" Automatic, language-dependent indentation, syntax coloring and other
" functionality.
filetype indent plugin on
syntax on

" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'airblade/vim-gitgutter'
call plug#end()

let g:gitgutter_set_sign_backgrounds=1
