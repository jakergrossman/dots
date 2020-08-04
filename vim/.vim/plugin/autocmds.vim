if has('autocmd')
    augroup JakeAutocmds
        autocmd!

        " enable emmet for html/css
        autocmd FileType html,htmldjango,css EmmetInstall
    augroup end
endif
