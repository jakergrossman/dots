if has('autocmd')
    augroup JakeAutocmds
        autocmd!

        " enable emmet for html/css
        autocmd FileType html,htmldjango,css EmmetInstall

        " indicate focused buffers
        autocmd BufEnter,BufWinEnter,FocusGained,VimEnter,WinEnter * call focus#focus()
        autocmd FocusLost,WinLeave * call focus#defocus()
    augroup end
endif
