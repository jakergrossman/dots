if has('autocmd')
    augroup JakeAutocmds
        autocmd!

        " enable emmet for html/css
        autocmd FileType html,html+django,css EmmetInstall
    augroup end
endif
