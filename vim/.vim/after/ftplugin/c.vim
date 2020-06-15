function! CFolds()
    let line = getline(v:lnum)

    " pre-processor folding
    if match(line, '^#if.*') >= 0
        return 'a1'
    elseif match(line, '^#endif\s*$') >= 0
        return 's1'
    endif

    " brace folding
    if match(line, '{\s*$') >= 0
        return 'a1'
    elseif match(line, '}\s*$') >= 0
        return 's1'
    else
        return '='
    endif
endfunction

function! CFoldText()
    " number of lines in fold
    let foldsize = (v:foldend-v:foldstart)

    " get current line text
    let linetext = getline(v:foldstart)

    " replace tabs with 4 spaces
    let linetext = substitute(linetext, '^\s*', '', 'g')

    " replace { with leading whitespace with the empty string
    let linetext = substitute(linetext, '\s*{\s*', '', '')

    return '+-- ['.foldsize.' lines] '.linetext.' '

endfunction

setlocal foldmethod=expr
setlocal foldexpr=CFolds()
setlocal foldtext=CFoldText()
