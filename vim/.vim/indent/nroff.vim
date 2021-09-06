function! nroff#fold_level(lnum) abort
    let l:line = getline(a:lnum)
    let l:next = getline(a:lnum+1)

    if l:line =~? '^\.sh'
        return '1'
    elseif l:line =~? '^\.ss'
        return '2'
    elseif l:next =~? '^\.sh'
        return '<1'
    elseif l:next =~? '^\.ss'
        return '<2'
    endif

    return '='
endfunction

function! nroff#fold_text(...) abort
    let l:line = getline(v:foldstart)
    let l:type = l:line[0:2]
    let l:sub = substitute(l:line, '....', '', '')
    if l:type ==? ".sh"
        return v:folddashes . ' SECTION: ' . l:sub
    elseif l:type ==? ".ss"
        return v:folddashes . ' SUBSECTION: ' . l:sub
    else
        return foldtext()
    endif
endfunction

set foldmethod=expr
set foldexpr=nroff#fold_level(v:lnum)
set foldtext=nroff#fold_text()
