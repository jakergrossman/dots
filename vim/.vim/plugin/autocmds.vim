if has('autocmd')
    augroup JakeAutocmds
        autocmd!

        " make current window more obvious by adjusting features in
        " non-focused windows
        if exists('+colorcolumn')
            autocmd BufEnter,FocusGained,VimEnter,WinEnter * let &l:colorcolumn=join(range(80, 255),',')
            autocmd FocusLost,WinLeave * let &l:colorcolumn=join(range(1,255), ',')
        endif
        autocmd InsertLeave,VimEnter,WinEnter * setlocal cursorline
        autocmd InsertEnter,WinLeave * setlocal nocursorline
        if has('statusline')
            autocmd BufEnter,FocusGained,VimEnter,WinEnter * call autocmds#focus_statusline()
            autocmd FocusLost,WinLeave * call autocmds#blur_statusline()
        endif

        " enable emmet for html/css
        autocmd FileType html,html+django,css EmmetInstall
    augroup end
endif
