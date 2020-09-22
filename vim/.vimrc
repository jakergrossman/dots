if v:progname == 'vi'
    set noloadplugins
endif

let mapleader="\<Space>"
let maplocalleader="\\"

if &loadplugins
    if has('packages')
        packadd! Apprentice
        packadd! vim-polyglot
        packadd! vim-commentary
        packadd! vim-gitgutter
        packadd! emmet-vim
        packadd! stepmania.vim
    else
        " Use Pathogen for plug-in loading.
        source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim
        call pathogen#infect('pack/bundle/start/{}')
    endif
endif

" Automatic, language-dependent indentation, syntax coloring and other
" functionality.
filetype indent plugin on
syntax on
