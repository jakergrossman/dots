if has('autocmd')
    augroup JakeAutocmds
        autocmd!

        " enable emmet for html/css
        autocmd FileType html,htmldjango,css EmmetInstall

        " indicate focused buffers
        autocmd BufEnter,BufWinEnter,FocusGained,VimEnter,WinEnter * call focus#focus()
        autocmd FocusLost,WinLeave * call focus#defocus()

        " turn on spell checking for gitcommit buffers
        autocmd FileType gitcommit setlocal spell
    augroup end
endif
