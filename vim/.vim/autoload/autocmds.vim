function! autocmds#focus_statusline() abort
    " 'setlocal statusline=' falls back to global statusline
    setlocal statusline=
endfunction

" condensed statusline (filename only)
function! autocmds#defocus_statusline() abort
    let l:condensed='%{statusline#outerpadding()}' " leading space
    let l:condensed.='%{statusline#relpath()}'     " relative path to file
    exec 'setlocal statusline=' . l:condensed
endfunction
