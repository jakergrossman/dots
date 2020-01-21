if v:progname == 'vi'
    set noloadplugins

endif

map <Space> <Leader>

if &loadplugins
    if has('packages')
        packadd! base16-vim
        packadd! haskell-vim
        packadd! vim-commentary
        packadd! vim-gitgutter
        packadd! vim-polyglot
        packadd! gv
        packadd! taboo
        packadd! vim-fugitive
        packadd! vim-haskell-indent
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

" After this file is sourced, plug-in code will be evaluated.
" See ~/.vim/after for files evaluated after that.
" See `:scriptnames` for a list of all scripts, in evaluation order.
" Launch Vim with `vim --startuptime vim.log` for profiling info.
"
" To see all leader mappings, including those from plug-ins:
"
"   vim -c 'set t_te=' -c 'set t_ti=' -c 'map <space>' -c q | sort
