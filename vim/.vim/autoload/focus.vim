function! focus#focus() abort
    " full statusline
    exec 'setlocal statusline=' . statusline#get_statusline(0)

    if exists('+colorcolumn')
        " indicate focused buffer with colorcolumn
        let &l:colorcolumn=join(range(1, 80), ',')
    endif
endfunction

function! focus#defocus() abort
    " condensed statusline
    exec 'setlocal statusline=' . statusline#get_statusline(1)

    if exists('+colorcolumn')
        " clear colorcolumn
        let &l:colorcolumn=''
    endif
endfunction
