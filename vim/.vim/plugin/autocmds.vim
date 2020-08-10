if has('autocmd')
    augroup JakeAutocmds
        autocmd!

        " enable emmet for html/css
        autocmd FileType html,htmldjango,css EmmetInstall

        " make focused window more apparent with colorcolumn
        if exists('+colorcolumn')
            autocmd BufEnter,FocusGained,VimEnter,WinEnter * let &l:colorcolumn=join(range(1, 80), ',')
            autocmd FocusLost,WinLeave * let &l:colorcolumn=''
        endif
    augroup end
endif
