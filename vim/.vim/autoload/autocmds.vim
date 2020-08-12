function! autocmds#focus_statusline() abort
    exec 'setlocal statusline=' . statusline#get_statusline(0)
endfunction

" condensed statusline (filename only)
function! autocmds#defocus_statusline() abort
    exec 'setlocal statusline=' . statusline#get_statusline(1)
endfunction
