if has('autocmd')
    augroup JakeAutocmds
        autocmd!

        " enable emmet for html/css
        autocmd FileType html,htmldjango,css EmmetInstall

        " make focused window more apparent with
        " colorcolumn and condensed statusline
        if exists('+colorcolumn')
            autocmd BufEnter,BufWinEnter,FocusGained,VimEnter,WinEnter * let &l:colorcolumn=join(range(1, 80), ',')
            autocmd FocusLost,WinLeave * let &l:colorcolumn=''
        endif

        " condense statusline on non-focused buffers
        autocmd BufEnter,BufWinEnter,FocusGained,VimEnter,WinEnter * call autocmds#focus_statusline()
        autocmd FocusLost,WinLeave * call autocmds#defocus_statusline()
    augroup end
endif
