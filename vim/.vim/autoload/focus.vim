function! focus#focus() abort
    if exists('+statusline')
        " full statusline
        exec 'setlocal statusline=' . statusline#get_statusline(0)
    endif

    if exists('+colorcolumn')
        " indicate focused buffer with colorcolumn
        let &l:colorcolumn=join(range(1, 80), ',')
    endif
endfunction

function! focus#defocus() abort
    if exists('+statusline')
        " condensed statusline
        exec 'setlocal statusline=' . statusline#get_statusline(1)
    endif

    if exists('+colorcolumn')
        " clear colorcolumn
        let &l:colorcolumn=''
    endif
endfunction
